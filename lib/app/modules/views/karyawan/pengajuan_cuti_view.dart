import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/controller/cuti_controller.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PengajuanCutiView extends StatelessWidget {
  final CutiController _cutiController = Get.put(CutiController());
  PengajuanCutiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.pengajuanCuti,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _cutiController.jenisAjuanController,
                inputLabel: Dictionary.jenisPengajuan,
                isDropdown: true,
                dropdownItems: const [
                  Dictionary.sakit,
                  Dictionary.cuti,
                  Dictionary.wfh,
                ],
                icon: Icons.assignment,
                onChanged: (value) {
                  _cutiController.jenisAjuanController.text =
                      Dictionary.mapTipe(value);
                },
              ),
              CustomTextField(
                controller: _cutiController.tanggalCutiController,
                inputLabel: Dictionary.tanggalCuti,
                isDate: true,
                icon: Icons.calendar_today_outlined,
                onChanged: (value) {
                  _cutiController.tanggalCutiController.text = value;
                },
              ),
              CustomTextField(
                controller: _cutiController.durasiController,
                inputLabel: Dictionary.durasi,
                isNumber: true,
              ),
              CustomTextField(
                controller: _cutiController.alasanController,
                inputLabel: Dictionary.alasan,
                isTextarea: true,
              ),
              CustomTextField(
                controller: _cutiController.buktiFileController,
                inputLabel: Dictionary.buktiFile,
                isFile: true,
                icon: Icons.attach_file,
              ),
              CustomTextField(
                controller: _cutiController.statusAjuanController,
                inputLabel: Dictionary.statusAjuan,
                initialValue: Dictionary.diajukan,
                readOnly: true,
              ),
              CustomTextField(
                controller: _cutiController.waktuPengajuanController,
                initialValue: DateFormat('EEEE, d MMMM y HH:mm')
                    .format(DateTime.now())
                    .toString(),
                inputLabel: Dictionary.waktuPengajuan,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: FilledButton(
          child: const Text(Dictionary.ajukan),
          onPressed: () {
            _cutiController.ajukanCuti();
          },
        ),
      ),
    );
  }
}
