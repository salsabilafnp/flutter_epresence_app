import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/controller/presensi_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatPresensiView extends StatelessWidget {
  final PresensiController _presensiController = Get.put(PresensiController());

  RiwayatPresensiView({super.key});

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
                _presensiController.getRiwayatPresensi(isLoadMore: true);
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
                      itemCount: _presensiController.presensi.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _presensiController.presensi.length) {
                          return _presensiController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink();
                        }
                        final presensi = _presensiController.presensi[index];
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
    BuildContext context,
    PresensiNetwork presensi,
    int index,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          _presensiController.isExpandedList[index].value =
              !_presensiController.isExpandedList[index].value;
        },
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(DateFormat('EEEE')
                            .format(DateTime.parse(presensi.date!))),
                        Text(
                          DateFormat('d MMMM yyyy')
                              .format(DateTime.parse(presensi.date!)),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(Dictionary.hadirMasuk),
                        Text(
                          presensi.checkInTime != null
                              ? DateFormat('HH:mm').format(DateTime.parse(
                                  '${presensi.date!} ${presensi.checkInTime!}'))
                              : '-',
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
                          presensi.checkOutTime != null
                              ? DateFormat('HH:mm').format(DateTime.parse(
                                  '${presensi.date!} ${presensi.checkOutTime!}'))
                              : '-',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(
                      _presensiController.isExpandedList[index].value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
              if (_presensiController.isExpandedList[index].value)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(Dictionary.lokasiMasuk),
                          const SizedBox(height: 5),
                          Text(
                            _formatLocation(presensi.latlonIn) ?? '-',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                      Column(
                        children: [
                          Text(Dictionary.lokasiPulang),
                          const SizedBox(height: 5),
                          Text(
                            _formatLocation(presensi.latlonOut) ?? '-',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
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
