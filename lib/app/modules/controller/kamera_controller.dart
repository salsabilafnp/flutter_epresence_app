import 'package:camera/camera.dart';
import 'package:get/get.dart';

class KameraController extends GetxController {
  late CameraController cameraController;
  // late FaceDetector faceDetector;
  RxBool isCameraInit = false.obs;
  // List<Face> faces = [];

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
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

      // faceDetector = FaceDetector(
      //   options: FaceDetectorOptions(
      //     enableContours: true,
      //     enableClassification: true,
      //   ),
      // );

      isCameraInit.value = true;
      update();
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // void _processCameraImage(CameraImage image) async {
  //   final inputImage = InputImage.fromBytes(
  //     bytes: image.planes[0].bytes,
  //     metadata: InputImageMetadata(
  //       size: Size(image.width.toDouble(), image.height.toDouble()),
  //       rotation: InputImageRotation.rotation0deg,
  //       format: InputImageFormat.nv21,
  //       bytesPerRow: image.planes[0].bytesPerRow,
  //     ),
  //   );

  //   try {
  //     Future.delayed(const Duration(milliseconds: 1000));
  //     final detectedFaces = await faceDetector.processImage(inputImage);
  //     faces = detectedFaces;
  //     update();
  //   } catch (e) {
  //     print('Error processing image: $e');
  //   }
  // }

  @override
  void onClose() {
    cameraController.dispose();
    // faceDetector.close();
    super.onClose();
  }
}
