import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatPresensiView extends StatefulWidget {
  const RiwayatPresensiView({super.key});

  @override
  _RiwayatPresensiViewState createState() => _RiwayatPresensiViewState();
}

class _RiwayatPresensiViewState extends State<RiwayatPresensiView> {
  String _selectedMonth = 'January';
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<RxBool> _isExpandedList = [];

  @override
  void initState() {
    super.initState();
    _isExpandedList =
        List.generate(_presensiDataFiltered.length, (index) => false.obs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.riwayatPresensi,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMonthFilter(),
            Expanded(
              child: ListView.builder(
                itemCount: _presensiDataFiltered.length,
                itemBuilder: (context, index) {
                  final presensi = _presensiDataFiltered[index];
                  return _buildPresensiCard(presensi, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthFilter() {
    return DropdownButton<String>(
      value: _selectedMonth,
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (String? newValue) {
        setState(() {
          _selectedMonth = newValue!;
        });
      },
      items: _months.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildPresensiCard(Presensi presensi, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          _isExpandedList[index].value = !_isExpandedList[index].value;
        },
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(DateFormat('EEEE')
                            .format(DateTime.parse(presensi.tanggal))),
                        Text(
                          DateFormat('d MMMM yyyy')
                              .format(DateTime.parse(presensi.tanggal)),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(Dictionary.hadirMasuk),
                        Text(
                          presensi.waktuMasuk,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(Dictionary.hadirPulang),
                        Text(
                          presensi.waktuPulang,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(
                      _isExpandedList[index].value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
              if (_isExpandedList[index].value)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(Dictionary.lokasiMasuk),
                          const SizedBox(height: 5),
                          Text(
                            presensi.lokasiMasuk,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                      Column(
                        children: [
                          Text(Dictionary.lokasiPulang),
                          const SizedBox(height: 5),
                          Text(
                            presensi.lokasiPulang,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Presensi> get _presensiDataFiltered {
    return presensiData
        .where((presensi) => presensi.userId == 'stf01')
        .toList();
  }
}
