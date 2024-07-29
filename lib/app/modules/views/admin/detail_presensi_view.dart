import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/card_info_user.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/controller/presensi_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPresensiView extends StatefulWidget {
  final int presensiId;

  DetailPresensiView({super.key}) : presensiId = Get.arguments as int;

  @override
  _DetailPresensiViewState createState() => _DetailPresensiViewState();
}

class _DetailPresensiViewState extends State<DetailPresensiView> {
  final PresensiController presensiController = Get.find();

  @override
  void initState() {
    super.initState();
    presensiController.getDetailPresensi(widget.presensiId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.detailPresensi,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          if (presensiController.detailPresensi.value == null) {
            return const Center(child: Text('No data available'));
          }

          // log(presensiController.detailPresensi.value!.date.toString());
          final data = presensiController.detailPresensi.value!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.presensi!.user != null)
                  CardInfoUser(user: data.presensi!.user!),
                const SizedBox(height: 10),
                _buildDetailPresensi(context, data.presensi!),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDetailPresensi(BuildContext context, Presensi presensi) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, d MMMM yyyy')
                  .format(DateTime.parse(presensi.date ?? '-')),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Presensi Masuk
                Column(
                  children: [
                    Text(
                      Dictionary.hadirMasuk,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.login_outlined,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          presensi.checkInTime ?? '-',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _formatLocation(presensi.latlonIn) ?? '-',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                // Presensi Pulang
                Column(
                  children: [
                    Text(
                      Dictionary.hadirPulang,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          presensi.checkOutTime ?? '-',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _formatLocation(presensi.latlonOut) ?? '-',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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

  String? _formatLocation(String? location) {
    if (location == null) {
      return null;
    }
    return location.split(',').join('\n');
  }
}
