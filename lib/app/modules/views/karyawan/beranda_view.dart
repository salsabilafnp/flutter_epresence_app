import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/time_date_display.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/theme.dart';

class BerandaView extends StatelessWidget {
  const BerandaView({super.key});

  @override
  Widget build(BuildContext context) {
    final String presensiMasuk = "08:00";
    final String presensiPulang = "17:00";

    return Scaffold(
      appBar: CustomAppBar(
        pageTitle: Dictionary.beranda,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPresensiHariIni(presensiMasuk, presensiPulang),
            const SizedBox(height: 20),
            Row(
              children: [
                // Riwayat Presensi
                Expanded(
                  child: OutlinedButton(
                    style: AppTheme.primaryOutlinedButtonStyle,
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
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
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
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
            const SizedBox(height: 20),
            FilledButton.icon(
              style: AppTheme.secondaryButtonStyle,
              onPressed: () {},
              icon: Icon(Icons.edit_note_outlined),
              label: Text(Dictionary.pengajuanCuti),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildPresensiHariIni(String presensiMasuk, String presensiPulang) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimeDateDisplay(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(Dictionary.waktuMasuk),
                    Text(Dictionary.lokasiMasuk),
                  ],
                ),
                Column(
                  children: [
                    Text(Dictionary.waktuMasuk),
                    Text(Dictionary.lokasiMasuk),
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
