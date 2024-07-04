import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/lokasi_view.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:geolocator/geolocator.dart';

class KameraView extends StatefulWidget {
  const KameraView({super.key});

  @override
  _KameraViewState createState() => _KameraViewState();
}

class _KameraViewState extends State<KameraView> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _determinePosition();
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

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double posCardBottom = MediaQuery.sizeOf(context).height / 7;
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.catatPresensiMasuk,
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
                },
              ),
            ),
          ),
          // Card Informasi Lokasi
          Positioned(
            bottom: posCardBottom,
            width: screenWidth,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Dictionary.presensiMasuk,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 10),
                        _currentPosition == null
                            ? const CircularProgressIndicator()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Latitude: ${_currentPosition!.latitude}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                  Text(
                                    'Longitude: ${_currentPosition!.longitude}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    // Lihat Lokasi
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_currentPosition != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LokasiView(
                                latitude: _currentPosition!.latitude,
                                longitude: _currentPosition!.longitude,
                              ),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.location_on),
                      label: Text(Dictionary.lihatLokasi),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
