import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image/image.dart' as img;

class KameraController extends GetxController {
  // final FaceRecognitionService faceRecognitionService =
  //     FaceRecognitionService();
  late CameraController cameraController;
  // Rx<Size?> previewSize = Rx<Size?>(null);
  // late FaceDetector faceDetector;
  RxBool isCameraInit = false.obs;
  // CameraImage? frame;
  // List<Face> faces = [];

  @override
  void onInit() {
    // faceDetector = FaceDetector(
    //   options: FaceDetectorOptions(
    //     enableContours: true,
    //     enableClassification: true,
    //   ),
    // );
    initializeCamera();
    super.onInit();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      Get.snackbar(
        Dictionary.defaultError,
        "No cameras available",
        margin: const EdgeInsets.all(20),
      );
      return;
    }

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );

    try {
      await cameraController.initialize();
      // cameraController.startImageStream(_processCameraImage);
      isCameraInit.value = true;
      update();
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultSuccess,
        'Error initializing camera: $e',
        margin: const EdgeInsets.all(20),
      );
    }
  }

  // InputImage getInputImage() {
  //   final WriteBuffer allBytes = WriteBuffer();
  //   for (final Plane plane in frame!.planes) {
  //     allBytes.putUint8List(plane.bytes);
  //   }
  //   final bytes = allBytes.done().buffer.asUint8List();
  //   final Size imageSize =
  //       Size(frame!.width.toDouble(), frame!.height.toDouble());
  //   final camera = cameras.firstWhere(
  //     (camera) => camera.lensDirection == CameraLensDirection.front,
  //   );
  //   final imageRotation =
  //       InputImageRotationValue.fromRawValue(camera.sensorOrientation);
  //   final inputImageFormat =
  //       InputImageFormatValue.fromRawValue(frame!.format.raw);
  //   final int bytesPerRow =
  //       frame?.planes.isNotEmpty == true ? frame!.planes.first.bytesPerRow : 0;

  //   final inputImageMetaData = InputImageMetadata(
  //     size: imageSize,
  //     rotation: imageRotation!,
  //     format: inputImageFormat!,
  //     bytesPerRow: bytesPerRow,
  //   );

  //   return InputImage.fromBytes(bytes: bytes, metadata: inputImageMetaData);
  // }

  // Future<void> doFaceDetectionOnFrame() async {
  //   if (frame == null) {
  //     log('Frame or FaceDetector is null');
  //     return;
  //   }

  //   InputImage inputImage = getInputImage();
  //   faces = await faceDetector.processImage(inputImage);

  //   // Panggil metode pengenalan wajah
  //   img.Image image = faceRecognitionService.convertYUV420ToImage(frame!);
  //   for (Face face in faces) {
  //     FaceEmbedding faceEmbedding =
  //         faceRecognitionService.recognize(image, face.boundingBox);

  //     List<double> embedding = faceEmbedding.embedding!;
  //     bool isValid = await faceRecognitionService.isValidFace(embedding);

  //     if (isValid) {
  //       Get.snackbar(
  //           Dictionary.defaultSuccess, "Face recognized successfully.");
  //     } else {
  //       Get.snackbar(Dictionary.defaultError, "Face not recognized.");
  //     }
  //   }
  // }

  // Future<void> verifikasiWajah() async {
  //   try {
  //     if (cameraController != null) {
  //       await cameraController.stopImageStream();
  //       frame = null;
  //       Get.snackbar(Dictionary.defaultSuccess, "Wajah telah terdaftar.");
  //     }
  //   } catch (e) {
  //     Get.snackbar(Dictionary.defaultError, "Wajah tidak dikenali.");
  //     print(e);
  //   }
  // }

  @override
  void onClose() {
    cameraController.dispose();
    // faceDetector.close();
    super.onClose();
  }
}
