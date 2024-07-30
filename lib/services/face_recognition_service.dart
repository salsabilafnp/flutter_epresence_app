// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

// class FaceRecognitionService {
//   late Interpreter interpreter;
//   static const int inputSize = 112;
//   static const String modelPath = 'assets/mobile_face_net.tflite';

//   FaceRecognitionService() {
//     _loadModel();
//   }

//   Future<void> _loadModel() async {
//     try {
//       interpreter = await Interpreter.fromAsset(modelPath);
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }

//   final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector(
//     FaceDetectorOptions(
//       enableContours: true,
//       enableLandmarks: true,
//       enableClassification: true,
//     ),
//   );

//   Future<List<Face>> detectFaces(CameraImage image) async {
//     final inputImage = _convertCameraImageToInputImage(image);
//     final faces = await _faceDetector.processImage(inputImage);
//     return faces;
//   }

//   InputImage _convertCameraImageToInputImage(CameraImage image) {
//     final Size imageSize = Size(
//       image.width.toDouble(),
//       image.height.toDouble(),
//     );
//     final InputImageRotation imageRotation = InputImageRotation.rotation90deg;
//     final InputImageFormat imageFormat =
//         InputImageFormatMethods.fromRawValue(image.format.raw) ??
//             InputImageFormat.NV21;
//     final planeData = image.planes.map((plane) {
//       return InputImagePlaneMetadata(
//         bytesPerRow: plane.bytesPerRow,
//         height: plane.height,
//         width: plane.width,
//       );
//     }).toList();

//     final inputImage = InputImage.fromBytes(
//       bytes: image.planes[0].bytes,
//       metadata: InputImageMetadata(
//         size: imageSize,
//         rotation: imageRotation,
//         format: imageFormat,
//         bytesPerRow: planeData,
//       ),
//     );

//     return inputImage;
//   }

//   void dispose() {
//     faceDetector.close();
//   }
// }
