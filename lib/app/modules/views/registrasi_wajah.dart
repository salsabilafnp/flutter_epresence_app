import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/face_painter.dart';
import 'package:flutter_epresence_app/app/modules/controller/kamera_controller.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';

class RegistrasiWajah extends StatelessWidget {
  final KameraController kameraController = Get.put(KameraController());

  RegistrasiWajah({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.registrasiWajah,
      ),
      body: Obx(
        () {
          if (!kameraController.isCameraInitialized.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                // Kamera
                Positioned(
                  height: screenHeight,
                  child:
                      CameraPreview(kameraController.cameraController.value!),
                ),
                // frame
                if (kameraController.frame != null)
                  CustomPaint(
                    painter: FacePainter(
                      kameraController.faces,
                      Size(
                        kameraController.frame!.width.toDouble(),
                        kameraController.frame!.height.toDouble(),
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
      // Tombol Verifikasi Wajah
      floatingActionButton: IconButton(
        icon: const Icon(Icons.circle),
        iconSize: 75,
        color: Theme.of(context).colorScheme.error,
        onPressed: () async {
          await kameraController.verifikasiWajah();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
