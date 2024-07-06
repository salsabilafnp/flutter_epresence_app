import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatCutiView extends StatefulWidget {
  const RiwayatCutiView({super.key});

  @override
  _RiwayatCutiViewState createState() => _RiwayatCutiViewState();
}

class _RiwayatCutiViewState extends State<RiwayatCutiView> {
  final List<Cuti> _cutiData =
      cutiData.where((cutiData) => cutiData.userId == 'stf01').toList();

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
                  final ajuanCuti = _cutiData[index];
                  return _buildCutiCard(ajuanCuti);
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
                      icon: Icons.assignment,
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
                      icon: Icons.assignment,
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

  Widget _buildCutiCard(Cuti ajuanCuti) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            RouteNames.editCuti,
            arguments: ajuanCuti.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(Dictionary.tanggalCuti),
                      Text(
                        DateFormat('d MMMM yyyy').format(DateTime.parse(
                          ajuanCuti.tanggalMulai,
                        )),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Icon(Icons.info_outline),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(Dictionary.durasi),
                      Text(
                        ajuanCuti.durasi.toString(),
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
                        ajuanCuti.jenisCuti.capitalize!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  _buildStatusChip(ajuanCuti.status),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String statusAjuan) {
    Color badgeColor;
    switch (statusAjuan) {
      case Dictionary.diajukan:
        badgeColor = Theme.of(context).colorScheme.secondary;
        break;
      case Dictionary.ditolak:
        badgeColor = Theme.of(context).colorScheme.error;
        break;
      case Dictionary.disetujui:
        badgeColor = Theme.of(context).colorScheme.onErrorContainer;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Chip(
      label: Text(statusAjuan),
      side: BorderSide(color: badgeColor),
      backgroundColor: badgeColor,
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
