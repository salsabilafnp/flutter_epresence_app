import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';

class PengajuanCutiView extends StatefulWidget {
  const PengajuanCutiView({super.key});

  @override
  _PengajuanCutiViewState createState() => _PengajuanCutiViewState();
}

class _PengajuanCutiViewState extends State<PengajuanCutiView> {
  final TextEditingController jenisPengajuanController =
      TextEditingController();
  final TextEditingController tanggalCutiController = TextEditingController();
  final TextEditingController durasiController = TextEditingController();
  final TextEditingController alasanController = TextEditingController();
  final TextEditingController buktiFileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        pageTitle: Dictionary.pengajuanCuti,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: jenisPengajuanController,
                inputLabel: Dictionary.jenisPengajuan,
                isDropdown: true,
                dropdownItems: [
                  Dictionary.diajukan,
                  Dictionary.disetujui,
                  Dictionary.ditolak,
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
                inputLabel: Dictionary.statusAjuan,
                readOnly: true,
              ),
              CustomTextField(
                inputLabel: Dictionary.waktuPengajuan,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: FilledButton(
          child: Text(Dictionary.ajukan),
          onPressed: () {},
        ),
      ),
    );
  }
}
