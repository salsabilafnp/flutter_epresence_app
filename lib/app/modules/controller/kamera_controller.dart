import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KameraController extends GetxController {
  Rx<CameraController?> cameraController = Rx<CameraController?>(null);
  Rx<Size?> previewSize = Rx<Size?>(null);
  RxBool isCameraInitialized = false.obs;

  KameraController() {
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        Get.snackbar(
            'Terjadi kesalahan', "Kamera tidak terdeteksi, silakan coba lagi.");
        print("No camera available");
        return;
      }

      final usedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () {
          throw Exception('No front camera found');
        },
      );

      cameraController.value = CameraController(
        usedCamera,
        ResolutionPreset.ultraHigh,
      );
      await cameraController.value!.initialize();
      previewSize.value = cameraController.value!.value.previewSize;
      isCameraInitialized.value = true;
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // verifikasi wajah
  Future<void> verifikasiWajah() async {
    if (cameraController.value != null) {
      await cameraController.value?.takePicture();
    } else {
      print('CameraController is not initialized');
    }
  }

  @override
  void onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }
}
