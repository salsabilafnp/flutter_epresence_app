import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:get/get.dart';

class KameraCutiView extends StatefulWidget {
  const KameraCutiView({super.key});

  @override
  _KameraCutiViewState createState() => _KameraCutiViewState();
}

class _KameraCutiViewState extends State<KameraCutiView> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _cameraController.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.pengajuanCuti,
      ),
      body: Stack(
        children: [
          // Kamera
          Positioned(
            height: screenHeight,
            child: _initializeControllerFuture == null
                ? const Center(child: CircularProgressIndicator())
                : FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Stack(
                          children: [
                            CameraPreview(_cameraController),
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
          // Tombol Verifikasi Wajah
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                icon: const Icon(Icons.circle),
                iconSize: 75,
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  // Verifikasi Wajah
                  // Go to form pengajuan cuti
                  Get.toNamed(RouteNames.pengajuanCuti);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
