import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/card_info_user.dart';
import 'package:flutter_epresence_app/app/components/color_status_cuti.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/controller/cuti_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailCutiView extends StatefulWidget {
  final int cutiId;

  DetailCutiView({super.key}) : cutiId = Get.arguments as int;

  @override
  _DetailCutiViewState createState() => _DetailCutiViewState();
}

class _DetailCutiViewState extends State<DetailCutiView> {
  final CutiController cutiController = Get.put(CutiController());

  @override
  void initState() {
    super.initState();
    cutiController.getDetailAjuan(widget.cutiId);
  }

  @override
  Widget build(BuildContext context) {
    final data = cutiController.detailCuti.value!;

    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.detailAjuanCuti,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          if (cutiController.detailCuti.value == null) {
            return const Center(child: Text('No data available'));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.cuti!.user != null)
                  CardInfoUser(user: data.cuti!.user!),
                const SizedBox(height: 10),
                _buildDetailCuti(context, data.cuti!),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              style: AppTheme.approveButonStyle,
              onPressed: () {
                // Handle approval action
                cutiController.konfirmasiAjuan(data.cuti!.id!, "approved");
              },
              child: const Text(Dictionary.disetujui),
            ),
            const SizedBox(height: 10),
            FilledButton(
              style: AppTheme.rejectButtonStyle,
              onPressed: () {
                // Handle rejection action
                cutiController.konfirmasiAjuan(data.cuti!.id!, "rejected");
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
                    _buildDetailItem(
                        context,
                        Dictionary.tanggalCuti,
                        DateFormat('EEEE, d MMMM yyyy')
                            .format(DateTime.parse(cuti.leaveDate!))),
                    const SizedBox(height: 10),
                    _buildDetailItem(context, Dictionary.statusAjuan, ''),
                    ColorStatusCuti(
                        statusAjuan: Dictionary.mapStatus(cuti.status!),
                        isForDetail: true),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem(context, Dictionary.durasi,
                        '${cuti.duration.toString()} Hari'),
                    const SizedBox(height: 10),
                    _buildDetailItem(context, Dictionary.jenisPengajuan,
                        Dictionary.mapTipe(cuti.permitType!).capitalize!),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildDetailItem(context, Dictionary.alasan, cuti.reason!),
            const SizedBox(height: 10),
            _buildDetailItem(context, Dictionary.buktiFile,
                cuti.fileUrl ?? 'Tidak ada bukti pendukung'),
            const SizedBox(height: 10),
            _buildDetailItem(
                context,
                Dictionary.waktuPengajuan,
                DateFormat('EEEE, d MMMM yyyy HH:MM')
                    .format(DateTime.parse(cuti.createdAt!))),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(height: 5),
        if (value != '') ...[
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ]
      ],
    );
  }
}
