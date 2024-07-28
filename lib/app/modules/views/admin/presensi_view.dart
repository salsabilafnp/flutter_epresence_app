import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/controller/presensi_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresensiView extends StatelessWidget {
  final PresensiController _presensiController = Get.put(PresensiController());

  PresensiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.riwayatPresensi,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: RefreshIndicator(
          onRefresh: _presensiController.reloadData,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !_presensiController.isLoading.value) {
                _presensiController.getSemuaPresensi();
              }
              return false;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                  label: const Text(Dictionary.filter),
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: _presensiController.semuaPresensi.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _presensiController.semuaPresensi.length) {
                          return _presensiController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink();
                        }
                        final presensi =
                            _presensiController.semuaPresensi[index];
                        return _buildPresensiCard(context, presensi!, index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(Dictionary.filter),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: _presensiController.tanggalAwal,
                      inputLabel: Dictionary.tanggalMulai,
                      isDate: true,
                      icon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _presensiController.dariTanggal.value ??
                              DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _presensiController.dariTanggal.value = pickedDate;
                            _presensiController.tanggalAwal.text =
                                DateFormat.yMMMMd().format(pickedDate);
                          });
                        }
                      },
                    ),
                    CustomTextField(
                      controller: _presensiController.tanggalAkhir,
                      inputLabel: Dictionary.tanggalAkhir,
                      isDate: true,
                      icon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                              _presensiController.sampaiTanggal.value ??
                                  DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _presensiController.sampaiTanggal.value =
                                pickedDate;
                            _presensiController.tanggalAkhir.text =
                                DateFormat.yMMMMd().format(pickedDate);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        _presensiController.aturFilter(
                          _presensiController.dariTanggal.value,
                          _presensiController.sampaiTanggal.value,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        Dictionary.terapkanFilter,
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      style: AppTheme.secondaryOutlinedButtonStyle,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(Dictionary.kembali),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPresensiCard(
      BuildContext context, Presensi presensi, int index) {
    final user = presensi.user;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user != null ? user.name ?? '-' : '-',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  DateFormat('EEEE, d MMMM yyyy')
                      .format(DateTime.parse(presensi.date!)),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(Dictionary.hadirMasuk),
                    Text(
                      presensi.checkInTime ?? '-',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(Dictionary.hadirPulang),
                    Text(
                      presensi.checkOutTime ?? '-',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextButton.icon(
                  label: const Text(Dictionary.lihatDetail),
                  icon: const Icon(Icons.info_outline, size: 15),
                  onPressed: () {
                    Get.toNamed(
                      RouteNames.detailPresensi,
                      arguments: presensi.id,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
