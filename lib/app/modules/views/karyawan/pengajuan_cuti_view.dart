import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';

class PengajuanCutiView extends StatelessWidget {
  const PengajuanCutiView({super.key});

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
                inputLabel: Dictionary.jenisPengajuan,
              ),
              CustomTextField(
                inputLabel: Dictionary.tanggalCuti,
                onTap: () {},
                onChanged: (value) {},
              ),
              CustomTextField(
                inputLabel: Dictionary.durasi,
                onTap: () {},
                onChanged: (value) {},
              ),
              CustomTextField(
                inputLabel: Dictionary.alasan,
              ),
              CustomTextField(
                inputLabel: Dictionary.buktiFile,
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
        margin: EdgeInsets.all(20),
        child: FilledButton(
          child: Text(Dictionary.ajukan),
          onPressed: () {},
        ),
      ),
    );
  }
}
