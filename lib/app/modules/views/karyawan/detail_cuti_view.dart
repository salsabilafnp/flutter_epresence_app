import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:intl/intl.dart';

class DetailCutiView extends StatefulWidget {
  const DetailCutiView({super.key});

  @override
  _DetailCutiViewState createState() => _DetailCutiViewState();
}

class _DetailCutiViewState extends State<DetailCutiView> {
  final TextEditingController jenisPengajuanController =
      TextEditingController(text: Dictionary.cuti);
  final TextEditingController tanggalCutiController =
      TextEditingController(text: '15 Juli 2024');
  final TextEditingController durasiController =
      TextEditingController(text: '3');
  final TextEditingController alasanController =
      TextEditingController(text: 'Liburan keluarga');
  final TextEditingController buktiFileController =
      TextEditingController(text: 'bukti_liburan.png');
  final TextEditingController statusAjuanController =
      TextEditingController(text: Dictionary.disetujui);
  final TextEditingController waktuPengajuanController = TextEditingController(
      text:
          DateFormat('EEEE, d MMMM y HH:mm').format(DateTime.now()).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.detailAjuanCuti,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: jenisPengajuanController,
                inputLabel: Dictionary.jenisPengajuan,
                isDropdown: true,
                dropdownItems: const [
                  Dictionary.sakit,
                  Dictionary.cuti,
                  Dictionary.wfh,
                ],
                icon: Icons.assignment,
                onChanged: (value) {
                  setState(() {
                    jenisPengajuanController.text = value;
                  });
                },
              ),
              CustomTextField(
                controller: tanggalCutiController,
                inputLabel: Dictionary.tanggalCuti,
                isDate: true,
                icon: Icons.calendar_today_outlined,
                onChanged: (value) {
                  setState(() {
                    tanggalCutiController.text = value;
                  });
                },
              ),
              CustomTextField(
                controller: durasiController,
                inputLabel: Dictionary.durasi,
                isNumber: true,
              ),
              CustomTextField(
                controller: alasanController,
                inputLabel: Dictionary.alasan,
                isTextarea: true,
              ),
              CustomTextField(
                controller: buktiFileController,
                inputLabel: Dictionary.buktiFile,
                isFile: true,
                icon: Icons.attach_file,
              ),
              CustomTextField(
                controller: statusAjuanController,
                inputLabel: Dictionary.statusAjuan,
                readOnly: true,
              ),
              CustomTextField(
                controller: waktuPengajuanController,
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
          onPressed: () {},
          child: const Text(Dictionary.ubahAjuan),
        ),
      ),
    );
  }
}
