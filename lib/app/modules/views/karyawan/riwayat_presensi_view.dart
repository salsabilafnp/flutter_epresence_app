import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';

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

  final List<Map<String, String>> _presensiData = [
    {
      'date': '2024-07-01',
      'day': 'Senin',
      'timeIn': '08:00',
      'timeOut': '17:00',
      'locationIn': '114.56789012\n-8.1234567',
      'locationOut': '114.56789012\n-8.1234567',
      'locationArea': 'Dalam Area Kantor'
    },
    {
      'date': '2024-07-02',
      'day': 'Selasa',
      'timeIn': '08:15',
      'timeOut': '17:05',
      'locationIn': '114.56789012\n-8.1234567',
      'locationOut': '114.56789012\n-8.1234567',
      'locationArea': 'Dalam Area Kantor'
    },
  ];

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
                itemCount: _presensiData.length,
                itemBuilder: (context, index) {
                  final presensi = _presensiData[index];
                  return _buildPresensiCard(presensi);
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

  Widget _buildPresensiCard(Map<String, String> presensi) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          // _showPresensiDetail(presensi);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('${presensi['day']}'),
                  Text('${presensi['date']}'),
                ],
              ),
              Column(
                children: [
                  Text(Dictionary.hadirMasuk),
                  Text('${presensi['timeIn']}'),
                ],
              ),
              Column(
                children: [
                  Text(Dictionary.hadirPulang),
                  Text('${presensi['timeOut']}'),
                ],
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}
