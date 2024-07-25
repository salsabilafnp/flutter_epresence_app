import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/time_date_display.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';

class BerandaAdminView extends StatelessWidget {
  final AuthController _authController = Get.find();

  BerandaAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.beranda,
        role: Dictionary.admin,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeDateDisplay(),
            const SizedBox(height: 50),
            Obx(() {
              final rekapAdmin = _authController.rekapitulasiAdmin.value;

              if (rekapAdmin != null) {
                return Column(
                  children: [
                    _buildRekapPresensi(
                      context,
                      rekapAdmin.totalPresensi!,
                      rekapAdmin.totalCuti!,
                    ),
                    const SizedBox(height: 20),
                    _buildRekapStatusCuti(
                      context,
                      rekapAdmin.totalCutiDiajukan!,
                      rekapAdmin.totalCutiDisetujui!,
                      rekapAdmin.totalCutiDitolak!,
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRekapPresensi(
    BuildContext context,
    int totalHadir,
    int totalAbsen,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(
              Dictionary.rekapPresensi,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPieChart(context, totalHadir, totalAbsen),
                Column(
                  children: [
                    Text(
                      totalHadir.toString(),
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                    ),
                    const SizedBox(height: 5),
                    const Text(Dictionary.hadir),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      totalAbsen.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            color: Theme.of(context).colorScheme.errorContainer,
                          ),
                    ),
                    const SizedBox(height: 5),
                    const Text(Dictionary.absen),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRekapStatusCuti(
    BuildContext context,
    int cutiDiajukan,
    int cutiDisetujui,
    int cutiDitolak,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text(
              Dictionary.rekapCuti,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      cutiDiajukan.toString(),
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                    ),
                    const SizedBox(height: 5),
                    const Text(Dictionary.diajukan),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      cutiDisetujui.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                    ),
                    const SizedBox(height: 5),
                    const Text(Dictionary.disetujui),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      cutiDitolak.toString(),
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                    ),
                    const SizedBox(height: 5),
                    const Text(Dictionary.ditolak),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(BuildContext context, int totalHadir, int totalAbsen) {
    return SizedBox(
      height: 100,
      width: 100,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 0,
          sections: [
            PieChartSectionData(
              value: totalHadir.toDouble(),
              color: Theme.of(context).colorScheme.tertiary,
              radius: 50,
              title:
                  '${(totalHadir / (totalHadir + totalAbsen) * 100).toStringAsFixed(1)}%',
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            PieChartSectionData(
              value: totalAbsen.toDouble(),
              color: Theme.of(context).colorScheme.errorContainer,
              radius: 50,
              title:
                  '${(totalAbsen / (totalHadir + totalAbsen) * 100).toStringAsFixed(1)}%',
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
