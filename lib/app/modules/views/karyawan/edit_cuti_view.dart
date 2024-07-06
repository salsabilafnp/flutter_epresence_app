import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditCutiView extends StatefulWidget {
  const EditCutiView({super.key});

  @override
  _EditCutiViewState createState() => _EditCutiViewState();
}

class _EditCutiViewState extends State<EditCutiView> {
  late TextEditingController jenisPengajuanController;
  late TextEditingController tanggalCutiController;
  late TextEditingController durasiController;
  late TextEditingController alasanController;
  late TextEditingController buktiFileController;
  late TextEditingController statusAjuanController;
  late TextEditingController waktuPengajuanController;

  @override
  void initState() {
    super.initState();

    // Get the cuti ID from the arguments
    final int cutiId = Get.arguments as int;

    final List<Cuti> _cutiData = cutiData.toList();
    final Cuti selectedCuti = _cutiData.firstWhere((cuti) => cuti.id == cutiId);

    jenisPengajuanController =
        TextEditingController(text: selectedCuti.jenisCuti);
    tanggalCutiController = TextEditingController(
        text: DateFormat('d MMMM yyyy')
            .format(DateTime.parse(selectedCuti.tanggalMulai)));
    durasiController =
        TextEditingController(text: selectedCuti.durasi.toString());
    alasanController = TextEditingController(text: selectedCuti.alasan);
    buktiFileController = TextEditingController(text: selectedCuti.fileUrl);
    statusAjuanController = TextEditingController(text: selectedCuti.status);
    waktuPengajuanController = TextEditingController(
        text: DateFormat('EEEE, d MMMM y HH:mm')
            .format(DateTime.now())
            .toString());
  }

  @override
  void dispose() {
    jenisPengajuanController.dispose();
    tanggalCutiController.dispose();
    durasiController.dispose();
    alasanController.dispose();
    buktiFileController.dispose();
    statusAjuanController.dispose();
    waktuPengajuanController.dispose();
    super.dispose();
  }

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
