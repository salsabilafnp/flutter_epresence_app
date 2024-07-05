import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/time_date_display.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';

class BerandaAdminView extends StatelessWidget {
  final int _totalHadir = 40;
  final int _totalAbsen = 10;
  final int _cutiDiajukan = 5;
  final int _cutiDisetujui = 3;
  final int _cutiDitolak = 2;

  const BerandaAdminView({super.key});

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
            _buildRekapPresensi(context, _totalHadir, _totalAbsen),
            const SizedBox(height: 20),
            _buildRekapStatusCuti(
              context,
              _cutiDiajukan,
              _cutiDisetujui,
              _cutiDitolak,
            ),
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
                      _totalHadir.toString(),
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
                      _totalAbsen.toString(),
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
                      _cutiDiajukan.toString(),
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
                      _cutiDisetujui.toString(),
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
                      _cutiDitolak.toString(),
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
