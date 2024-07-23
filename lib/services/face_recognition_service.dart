import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/face_embedding.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class FaceRecognitionService {
  late Interpreter _interpreter;
  static const int inputSize = 112;
  static const String modelPath = 'assets/mobile_face_net.tflite';

  FaceRecognitionService() {
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  List<dynamic> _imageToArray(img.Image inputImage) {
    img.Image resizedImage = img.copyResize(
      inputImage,
      width: inputSize,
      height: inputSize,
    );
    List<double> flattenedList = resizedImage.data!
        .expand((channel) => [channel.r, channel.g, channel.b])
        .map((value) => value.toDouble())
        .toList();
    Float32List float32Array = Float32List.fromList(flattenedList);
    int channels = 3;
    int height = inputSize;
    int width = inputSize;
    Float32List reshapedArray = Float32List(1 * height * width * channels);
    for (int c = 0; c < channels; c++) {
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          int index = c * height * width + h * width + w;
          reshapedArray[index] =
              (float32Array[c * height * width + h * width + w] - 127.5) /
                  127.5;
        }
      }
    }
    return reshapedArray.reshape([1, inputSize, inputSize, 3]);
  }

  FaceEmbedding recognize(img.Image image, Rect location) {
    img.Image croppedFace = img.copyCrop(image,
        x: location.left.toInt(),
        y: location.top.toInt(),
        width: location.width.toInt(),
        height: location.height.toInt());

    var input = _imageToArray(croppedFace);

    List output = List.filled(1 * 192, 0).reshape([1, 192]);

    _interpreter.run(input, output);

    List<double> embedding = output.first.cast<double>();

    return FaceEmbedding(location, embedding);
  }

  img.Image convertYUV420ToImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;

    final yRowStride = cameraImage.planes[0].bytesPerRow;
    final uvRowStride = cameraImage.planes[1].bytesPerRow;
    final uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = img.Image(width: width, height: height);

    for (var w = 0; w < width; w++) {
      for (var h = 0; h < height; h++) {
        final uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
        final yIndex = h * yRowStride + w;

        final y = cameraImage.planes[0].bytes[yIndex];
        final u = cameraImage.planes[1].bytes[uvIndex];
        final v = cameraImage.planes[2].bytes[uvIndex];

        image.data!.setPixelR(w, h, _yuv2rgb(y, u, v));
      }
    }
    return image;
  }

  int _yuv2rgb(int y, int u, int v) {
    var r = (y + v * 1436 / 1024 - 179).round();
    var g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
    var b = (y + u * 1814 / 1024 - 227).round();

    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return 0xff000000 |
        ((b << 16) & 0xff0000) |
        ((g << 8) & 0xff00) |
        (r & 0xff);
  }

  double calculateDistance(List<double> emb1, List<double> emb2) {
    double distance = 0;
    for (int i = 0; i < emb1.length; i++) {
      double diff = emb1[i] - emb2[i];
      distance += diff * diff;
    }
    return sqrt(distance);
  }

  Future<bool> isValidFace(List<double> emb) async {
    final authData = AuthController().user;
    final faceEmbedding = authData.value!.faceEmbedding;
    double distance = calculateDistance(
        emb,
        faceEmbedding!
            .split(',')
            .map((e) => double.parse(e))
            .toList()
            .cast<double>());

    print("distance= $distance");

    return distance < 1;
  }
}
