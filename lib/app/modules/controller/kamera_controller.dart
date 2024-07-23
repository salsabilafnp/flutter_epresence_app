import 'dart:developer';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_epresence_app/app/modules/models/face_embedding.dart';
import 'package:flutter_epresence_app/services/face_recognition_service.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;

class KameraController extends GetxController {
  RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  Rx<CameraController?> cameraController = Rx<CameraController?>(null);
  Rx<Size?> previewSize = Rx<Size?>(null);
  RxBool isCameraInitialized = false.obs;

  late FaceDetector faceDetector;
  final FaceRecognitionService faceRecognitionService =
      FaceRecognitionService();

  CameraImage? frame;
  List<Face> faces = [];

  KameraController() {
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras.value = await availableCameras();
      if (cameras.isEmpty) {
        Get.snackbar("Error", "No cameras available");
        return;
      }

      final CameraDescription usedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController.value = CameraController(
        usedCamera,
        ResolutionPreset.medium,
      );

      await cameraController.value!.initialize();
      previewSize.value = cameraController.value!.value.previewSize;
      isCameraInitialized.value = true;

      cameraController.value?.startImageStream((CameraImage image) {
        frame = image;
        doFaceDetectionOnFrame();
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  InputImage getInputImage() {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in frame!.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(frame!.width.toDouble(), frame!.height.toDouble());
    final camera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(frame!.format.raw);
    final int bytesPerRow =
        frame?.planes.isNotEmpty == true ? frame!.planes.first.bytesPerRow : 0;

    final inputImageMetaData = InputImageMetadata(
      size: imageSize,
      rotation: imageRotation!,
      format: inputImageFormat!,
      bytesPerRow: bytesPerRow,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: inputImageMetaData);
  }

  Future<void> doFaceDetectionOnFrame() async {
    if (frame == null) {
      log('Frame or FaceDetector is null');
      return;
    }

    InputImage inputImage = getInputImage();
    faces = await faceDetector.processImage(inputImage);

    // Panggil metode pengenalan wajah
    img.Image image = faceRecognitionService.convertYUV420ToImage(frame!);
    for (Face face in faces) {
      FaceEmbedding faceEmbedding =
          faceRecognitionService.recognize(image, face.boundingBox);

      List<double> embedding = faceEmbedding.embedding!;
      bool isValid = await faceRecognitionService.isValidFace(embedding);

      if (isValid) {
        Get.snackbar(
            Dictionary.defaultSuccess, "Face recognized successfully.");
      } else {
        Get.snackbar(Dictionary.defaultError, "Face not recognized.");
      }
    }
  }

  Future<void> verifikasiWajah() async {
    try {
      if (cameraController.value != null) {
        await cameraController.value!.stopImageStream();
        frame = null;
        Get.snackbar(Dictionary.defaultSuccess, "Wajah telah terdaftar.");
      }
    } catch (e) {
      Get.snackbar(Dictionary.defaultError, "Wajah tidak dikenali.");
      print(e);
    }
  }

  @override
  void onClose() {
    cameraController.value?.dispose();
    faceDetector.close();
    super.onClose();
  }
}
