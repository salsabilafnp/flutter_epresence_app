import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/notifikasi.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:intl/intl.dart';

class NotifikasiView extends StatelessWidget {
  final List<Notifikasi> notifications = [
    Notifikasi(
      title: 'Pengingat Presensi',
      message: 'Jangan lupa untuk presensi masuk!',
      date: DateTime.now().subtract(Duration(hours: 1)),
      isReminder: true,
    ),
    Notifikasi(
      title: 'Pengajuan Cuti Ditindaklanjuti',
      message: 'Pengajuan cuti Anda telah disetujui.',
      date: DateTime.now().subtract(Duration(days: 1)),
      isReminder: false,
    ),
  ];

  NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        pageTitle: Dictionary.notifikasi,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return _buildNotificationCard(notifications[index]);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Notifikasi notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy, HH:mm').format(notification.date),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(notification.message),
          ],
        ),
      ),
    );
  }
}
