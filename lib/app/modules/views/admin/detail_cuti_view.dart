import 'package:flutter/material.dart';
// import 'package:flutter_epresence_app/app/components/card_info_user.dart';
import 'package:flutter_epresence_app/app/components/color_status_cuti.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
// import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailCutiView extends StatelessWidget {
  final int cutiId = Get.arguments as int;

  DetailCutiView({super.key});

  @override
  Widget build(BuildContext context) {
    final Cuti cuti = cutiData.firstWhere((cuti) => cuti.id == cutiId);
    // final User user = users.firstWhere((user) => user.userId == cuti.userId);

    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.detailAjuanCuti,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CardInfoUser(user: user),
                const SizedBox(height: 10),
                _buildDetailCuti(context, cuti),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              style: AppTheme.approveButonStyle,
              onPressed: () {
                // Disetujui
              },
              child: const Text(Dictionary.disetujui),
            ),
            const SizedBox(height: 10),
            FilledButton(
              style: AppTheme.rejectButtonStyle,
              onPressed: () {
                // Ditolak
              },
              child: const Text(Dictionary.ditolak),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCuti(BuildContext context, Cuti cuti) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tanggal Awal Ajuan
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Dictionary.tanggalCuti,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('EEEE, d MMMM yyyy')
                              .format(DateTime.parse(cuti.tanggalMulai)),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Status Ajuan
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Dictionary.statusAjuan,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(height: 5),
                        ColorStatusCuti(
                          statusAjuan: cuti.status,
                          isForDetail: true,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Durasi
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Dictionary.durasi,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${cuti.durasi.toString()} Hari',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Jenis Pengajuan
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Dictionary.durasi,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          cuti.jenisCuti.capitalize!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Alasan
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Dictionary.alasan,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 5),
                Text(
                  cuti.alasan,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Bukti File
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Dictionary.buktiFile,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 5),
                Text(
                  cuti.fileUrl,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                // Preview Bukti Ajuan
                // Image.asset(),
              ],
            ),
            const SizedBox(height: 10),
            // Waktu Pengajuan
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Dictionary.waktuPengajuan,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('EEEE, d MMMM yyyy HH:MM').format(DateTime.now()),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
