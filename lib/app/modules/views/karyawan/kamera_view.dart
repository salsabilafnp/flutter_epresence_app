import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/controller/kamera_controller.dart';
import 'package:flutter_epresence_app/app/modules/controller/presensi_controller.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/lokasi_view.dart';
import 'package:flutter_epresence_app/services/geolocation_service.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:get/get.dart';

class KameraView extends StatelessWidget {
  final bool kameraCuti;
  final KameraController kameraController = Get.put(KameraController());
  final GeolocationService geolocationController =
      Get.put(GeolocationService());
  final PresensiController presensiController = Get.put(PresensiController());

  KameraView({
    super.key,
    this.kameraCuti = false,
  });

  @override
  Widget build(BuildContext context) {
    double posCardBottom = MediaQuery.of(context).size.height / 7;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.verifikasiWajah,
      ),
      body: Obx(
        () {
          if (!kameraController.isCameraInit.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                // Kamera
                Positioned(
                  height: screenHeight,
                  child: CameraPreview(kameraController.cameraController),
                ),
                // Card Informasi Lokasi
                if (!kameraCuti)
                  cardInfoLocation(context, posCardBottom, screenWidth)
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
          // Verifikasi Wajah
          // kamera cuti
          if (kameraCuti) {
            Get.toNamed(RouteNames.pengajuanCuti);
          } else {
            // dialog konfirmasi catat presensi
            dialogCatatPresensi();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void dialogCatatPresensi() {
    final currentPosition = geolocationController.currentPosition.value;
    Get.defaultDialog(
      title: presensiController.isPresensiHariIni.value
          ? "${Dictionary.konfirmasi} ${Dictionary.catatPresensiPulang}"
          : "${Dictionary.konfirmasi} ${Dictionary.catatPresensiMasuk}",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Lokasi saat ini:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Latitude: ${currentPosition!.latitude}',
          ),
          Text(
            'Longitude: ${currentPosition.longitude}',
          ),
          const SizedBox(height: 20),
        ],
      ),
      textConfirm: Dictionary.ya,
      textCancel: Dictionary.tidak,
      onConfirm: () {
        presensiController.isPresensiHariIni.value
            ? presensiController.catatPresensiKeluar(
                currentPosition.latitude,
                currentPosition.longitude,
              )
            : presensiController.catatPresensiMasuk(
                currentPosition.latitude,
                currentPosition.longitude,
              );
      },
    );
  }

  Widget cardInfoLocation(
    BuildContext context,
    double bottomPosition,
    double widthSize,
  ) {
    return Positioned(
      bottom: bottomPosition,
      width: widthSize,
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
                    presensiController.isPresensiHariIni.value
                        ? Dictionary.presensiPulang
                        : Dictionary.presensiMasuk,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (geolocationController.currentPosition.value == null) {
                      return const CircularProgressIndicator();
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Latitude: ${geolocationController.currentPosition.value!.latitude}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            'Longitude: ${geolocationController.currentPosition.value!.longitude}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ],
              ),
              // Lihat Lokasi
              ElevatedButton.icon(
                onPressed: () {
                  if (geolocationController.currentPosition.value != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LokasiView(
                          latitude: geolocationController
                              .currentPosition.value!.latitude,
                          longitude: geolocationController
                              .currentPosition.value!.longitude,
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
    );
  }
}
