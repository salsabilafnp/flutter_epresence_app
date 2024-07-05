import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresensiDetailView extends StatelessWidget {
  final int presensiId = Get.arguments as int;

  PresensiDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Presensi presensi =
        presensiData.firstWhere((presensi) => presensi.id == presensiId);

    return Scaffold(
      appBar: CustomAppBar(
        pageTitle: Dictionary.detailPresensi,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, dd MMMM yyyy')
                  .format(DateTime.parse(presensi.tanggal)),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildDetailRow(Dictionary.nama, _getUserName(presensi.userId)),
            const SizedBox(height: 10),
            _buildDetailRow(Dictionary.hadirMasuk, presensi.waktuMasuk),
            const SizedBox(height: 10),
            _buildDetailRow(Dictionary.hadirPulang, presensi.waktuPulang),
            const SizedBox(height: 10),
            _buildDetailRow(Dictionary.lokasiMasuk, presensi.lokasiMasuk),
            const SizedBox(height: 10),
            _buildDetailRow(Dictionary.lokasiPulang, presensi.lokasiPulang),
          ],
        ),
      ),
    );
  }

  String _getUserName(String? userId) {
    final user = users.firstWhere(
      (u) => u.userId == userId,
      orElse: () => User(
        userId: '',
        nama: 'Unknown',
        email: '',
        phoneNumber: '',
        role: '',
        employeeType: '',
        department: '',
        position: '',
        imageUrl: '',
      ),
    );
    return user.nama;
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
