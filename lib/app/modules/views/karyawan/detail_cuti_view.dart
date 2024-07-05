import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailCutiView extends StatefulWidget {
  const DetailCutiView({super.key});

  @override
  _DetailCutiViewState createState() => _DetailCutiViewState();
}

class _DetailCutiViewState extends State<DetailCutiView> {
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

    // Fetch the cuti data based on the ID (for simplicity, using a hardcoded list)
    final List<Cuti> cutiData = [
      Cuti(
        id: 1,
        tanggalMulai: '2024-06-27',
        durasi: 2,
        jenisCuti: 'sakit',
        alasan: 'Sedang dalam perawatan medis',
        fileUrl: 'foto_rs.png',
        status: 'Disetujui',
      ),
      Cuti(
        id: 2,
        tanggalMulai: '2024-07-08',
        durasi: 2,
        jenisCuti: 'wfh',
        alasan: 'Mengurus perpindahan rumah',
        fileUrl: 'bukti_foto.png',
        status: 'Diajukan',
      ),
    ];

    final Cuti selectedCuti = cutiData.firstWhere((cuti) => cuti.id == cutiId);

    jenisPengajuanController =
        TextEditingController(text: selectedCuti.jenisCuti);
    tanggalCutiController = TextEditingController(
        text: DateFormat('dd MMMM yyyy')
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
