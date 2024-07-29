import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/time_date_display.dart';
import 'package:flutter_epresence_app/app/modules/controller/presensi_controller.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class BerandaView extends StatelessWidget {
  final PresensiController _presensiController = Get.put(PresensiController());

  BerandaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.beranda,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              // jam masuk dan pulang hari ini
              if (_presensiController.presensiHariIni.value == null) {
                return _buildPresensiHariIni(
                  context,
                  "--:--",
                  "--:--",
                );
              } else {
                return _buildPresensiHariIni(
                  context,
                  _presensiController.presensiHariIni.value!.checkInTime!,
                  _presensiController.presensiHariIni.value!.checkOutTime ??
                      "--:--",
                );
              }
            }),
            const SizedBox(height: 30),
            Row(
              children: [
                // Riwayat Presensi
                Expanded(
                  child: OutlinedButton(
                    style: AppTheme.primaryOutlinedButtonStyle,
                    onPressed: () {
                      Get.toNamed(RouteNames.riwayatPresensiStaff);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Column(
                        children: [
                          Icon(Icons.work_history_outlined),
                          SizedBox(height: 5),
                          Text(
                            Dictionary.riwayatPresensi,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                // Riwayat Cuti
                Expanded(
                  child: OutlinedButton(
                    style: AppTheme.secondaryOutlinedButtonStyle,
                    onPressed: () {
                      Get.toNamed(RouteNames.riwayatCutiStaff);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Column(
                        children: [
                          Icon(Icons.edit_calendar_outlined),
                          SizedBox(height: 5),
                          Text(
                            Dictionary.riwayatAjuanCuti,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            FilledButton.icon(
              style: AppTheme.primaryButtonStyle,
              onPressed: () {
                Get.toNamed(RouteNames.kameraCuti);
              },
              icon: Icon(Symbols.note_alt),
              label: Text(Dictionary.pengajuanCuti),
            ),
            const SizedBox(height: 15),
            FilledButton.icon(
              style: AppTheme.secondaryButtonStyle,
              onPressed: () {
                Get.toNamed(RouteNames.registrasiWajah);
              },
              icon: Icon(Symbols.familiar_face_and_zone),
              label: Text(Dictionary.registrasiWajah),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresensiHariIni(
    BuildContext context,
    String presensiMasuk,
    String presensiPulang,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimeDateDisplay(),
            const SizedBox(height: 30),
            Text(
              Dictionary.presensiHariIni,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.login_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          Dictionary.hadirMasuk,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          presensiMasuk,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          Dictionary.hadirPulang,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          presensiPulang,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
