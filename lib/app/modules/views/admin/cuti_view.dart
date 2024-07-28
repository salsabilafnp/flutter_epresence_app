import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/color_status_cuti.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/controller/cuti_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CutiView extends StatelessWidget {
  final CutiController _cutiController = Get.put(CutiController());

  CutiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.riwayatAjuanCuti,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: RefreshIndicator(
          onRefresh: _cutiController.reloadData,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !_cutiController.isLoading.value) {
                _cutiController.getSemuaCuti();
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
                      itemCount: _cutiController.semuaCuti.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _cutiController.semuaCuti.length) {
                          return _cutiController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink();
                        }
                        final data = _cutiController.semuaCuti[index];
                        return _buildCutiCard(context, data!, index);
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

  // filter dialog
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
                    // Berdasarkan Tanggal
                    Text(
                      Dictionary.filterTanggal,
                      style: Theme.of(context).textTheme.headlineSmall!,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _cutiController.tanggalAwal,
                      inputLabel: Dictionary.tanggalMulai,
                      isDate: true,
                      icon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _cutiController.dariTanggal.value ??
                              DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _cutiController.dariTanggal.value = pickedDate;
                            _cutiController.tanggalAwal.text =
                                DateFormat.yMMMMd().format(pickedDate);
                          });
                        }
                      },
                    ),
                    CustomTextField(
                      controller: _cutiController.tanggalAkhir,
                      inputLabel: Dictionary.tanggalAkhir,
                      isDate: true,
                      icon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _cutiController.sampaiTanggal.value ??
                              DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _cutiController.sampaiTanggal.value = pickedDate;
                            _cutiController.tanggalAkhir.text =
                                DateFormat.yMMMMd().format(pickedDate);
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    // Berdasarkan Jenis Ajuan
                    Text(
                      Dictionary.filterJenisAjuan,
                      style: Theme.of(context).textTheme.headlineSmall!,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: TextEditingController(
                          text: _cutiController.selectedPermitType!.value),
                      inputLabel: Dictionary.jenisPengajuan,
                      isDropdown: true,
                      dropdownItems: [
                        _cutiController.selectedPermitType!.value,
                        Dictionary.sakit,
                        Dictionary.cuti,
                        Dictionary.wfh,
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _cutiController.selectedPermitType!.value = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Berdasarkan Status Ajuan
                    Text(
                      Dictionary.filterStatusAjuan,
                      style: Theme.of(context).textTheme.headlineSmall!,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: TextEditingController(
                          text: _cutiController.selectedStatus!.value),
                      inputLabel: Dictionary.statusAjuan,
                      isDropdown: true,
                      dropdownItems: [
                        _cutiController.selectedStatus!.value,
                        Dictionary.diajukan,
                        Dictionary.disetujui,
                        Dictionary.ditolak,
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _cutiController.selectedStatus!.value = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
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

  // Cuti Card
  Widget _buildCutiCard(BuildContext context, Cuti cuti, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cuti.user!.name!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ColorStatusCuti(
                    statusAjuan: Dictionary.mapStatus(cuti.status!)),
                TextButton.icon(
                  label: const Text(Dictionary.konfirmasi),
                  icon: const Icon(
                    Icons.check_circle_outline,
                    size: 15,
                  ),
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    Get.toNamed(
                      RouteNames.detailCuti,
                      arguments: cuti.id,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(Dictionary.tanggalCuti),
                    Text(
                      DateFormat('d MMMM yyyy')
                          .format(DateTime.parse(cuti.leaveDate!)),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(Dictionary.durasi),
                    Text(
                      cuti.duration!.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(Dictionary.jenisPengajuan),
                    Text(
                      Dictionary.mapTipe(cuti.permitType!).capitalize!,
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
      ),
    );
  }
}
