import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/controller/cuti_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditCutiView extends StatelessWidget {
  final CutiController _cutiController = Get.find();
  final int cutiId = Get.arguments as int;

  EditCutiView({super.key});

  @override
  Widget build(BuildContext context) {
    CutiNetwork? selectedCuti = _cutiController.cuti.firstWhere(
      (element) => element!.id == cutiId,
      orElse: () => null,
    );
    bool isDiajukan = selectedCuti?.status == 'pending';

    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.detailAjuanCuti,
      ),
      body: GetBuilder<CutiController>(
        builder: (cutiController) {
          if (selectedCuti == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: cutiController.jenisAjuanController,
                    inputLabel: Dictionary.jenisPengajuan,
                    initialValue: selectedCuti.permitType,
                    isDropdown: true,
                    dropdownItems: const [
                      Dictionary.sakit,
                      Dictionary.cuti,
                      Dictionary.wfh,
                    ],
                    onChanged: (value) {
                      cutiController.jenisAjuanController.text = value;
                    },
                  ),
                  CustomTextField(
                    controller: cutiController.tanggalCutiController,
                    inputLabel: Dictionary.tanggalCuti,
                    initialValue: selectedCuti.leaveDate,
                    isDate: true,
                    icon: Icons.calendar_today_outlined,
                    onChanged: (value) {
                      cutiController.tanggalCutiController.text = value;
                    },
                  ),
                  CustomTextField(
                    controller: cutiController.durasiController,
                    inputLabel: Dictionary.durasi,
                    initialValue: selectedCuti.duration.toString(),
                    isNumber: true,
                  ),
                  CustomTextField(
                    controller: cutiController.alasanController,
                    inputLabel: Dictionary.alasan,
                    initialValue: selectedCuti.reason,
                    isTextarea: true,
                  ),
                  CustomTextField(
                    controller: cutiController.buktiFileController,
                    inputLabel: Dictionary.buktiFile,
                    initialValue: selectedCuti.fileUrl,
                    isFile: true,
                    icon: Icons.attach_file,
                  ),
                  CustomTextField(
                    controller: cutiController.statusAjuanController,
                    inputLabel: Dictionary.statusAjuan,
                    initialValue: Dictionary.mapStatus(selectedCuti.status!),
                    readOnly: true,
                  ),
                  CustomTextField(
                    controller: cutiController.waktuPengajuanController,
                    inputLabel: Dictionary.waktuPengajuan,
                    initialValue: selectedCuti.createdAt != null
                        ? DateFormat('EEEE, d MMMM y')
                            .format(DateTime.parse(selectedCuti.createdAt!))
                        : '',
                    readOnly: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: FilledButton(
          onPressed: isDiajukan
              ? () {
                  _cutiController.perbaruiCuti(selectedCuti!.id!);
                }
              : null,
          child: const Text(Dictionary.ubahAjuan),
        ),
      ),
    );
  }
}
