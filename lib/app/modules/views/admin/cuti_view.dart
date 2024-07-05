import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CutiView extends StatefulWidget {
  const CutiView({super.key});

  @override
  _CutiViewState createState() => _CutiViewState();
}

class _CutiViewState extends State<CutiView> {
  final List<Cuti> _cutiData = cutiData.toList();

  DateTime? _fromDate;
  DateTime? _toDate;
  String _selectedPermitType = 'Semua';
  String _selectedStatus = 'Semua';

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.riwayatAjuanCuti,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            FilledButton.icon(
              onPressed: () {
                _showFilterDialog();
              },
              label: const Text(Dictionary.filter),
              icon: const Icon(Icons.filter_alt_outlined),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _cutiData.length,
                itemBuilder: (context, index) {
                  final cuti = _cutiData[index];
                  return _buildCutiCard(cuti);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // filter dialog
  void _showFilterDialog() {
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
                      controller: _fromDateController,
                      inputLabel: Dictionary.tanggalMulai,
                      isDate: true,
                      icon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _fromDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _fromDate = pickedDate;
                            _fromDateController.text =
                                DateFormat.yMMMMd().format(pickedDate);
                          });
                        }
                      },
                    ),
                    CustomTextField(
                      controller: _toDateController,
                      inputLabel: Dictionary.tanggalAkhir,
                      isDate: true,
                      icon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _toDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _toDate = pickedDate;
                            _toDateController.text =
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
                      controller:
                          TextEditingController(text: _selectedPermitType),
                      inputLabel: Dictionary.jenisPengajuan,
                      isDropdown: true,
                      dropdownItems: [
                        _selectedPermitType,
                        Dictionary.sakit,
                        Dictionary.cuti,
                        Dictionary.wfh,
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPermitType = newValue!;
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
                      controller: TextEditingController(text: _selectedStatus),
                      inputLabel: Dictionary.statusAjuan,
                      isDropdown: true,
                      dropdownItems: [
                        _selectedStatus,
                        Dictionary.diajukan,
                        Dictionary.disetujui,
                        Dictionary.ditolak,
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStatus = newValue!;
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

  // Fungsi untuk mendapatkan nama pengguna berdasarkan userId
  String _getUserName(String? userId) {
    final user = users.firstWhere(
      (u) => u.userId == userId,
      orElse: () => User(
        userId: '',
        nama: 'Unknown',
        email: '',
        phoneNumber: '',
        role: '',
        employeeType: '',
        department: '',
        position: '',
        imageUrl: '',
      ),
    );
    return user.nama;
  }

  // Cuti Card
  Widget _buildCutiCard(Cuti cuti) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getUserName(cuti.userId),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                _buildStatusColor(cuti.status),
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
                      DateFormat('dd MMMM yyyy').format(DateTime.parse(
                        cuti.tanggalMulai,
                      )),
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
                      cuti.durasi.toString(),
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
                      cuti.jenisCuti.capitalize!,
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

  Widget _buildStatusColor(String statusAjuan) {
    Color textColor;
    switch (statusAjuan) {
      case Dictionary.diajukan:
        textColor = Theme.of(context).colorScheme.secondary;
        break;
      case Dictionary.ditolak:
        textColor = Theme.of(context).colorScheme.error;
        break;
      case Dictionary.disetujui:
        textColor = Theme.of(context).colorScheme.onErrorContainer;
        break;
      default:
        textColor = Colors.grey;
    }

    return Text(
      statusAjuan,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }
}
