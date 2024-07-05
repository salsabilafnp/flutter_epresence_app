import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/notifikasi.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:intl/intl.dart';

class NotifikasiAdminView extends StatelessWidget {
  final List<Notifikasi> _adminNotifications =
      notifications.where((notifikasi) => !notifikasi.isForStaff).toList();

  NotifikasiAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.notifikasi,
        role: Dictionary.admin,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _adminNotifications.length,
          itemBuilder: (context, index) {
            return _buildNotificationCard(context, _adminNotifications[index]);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, Notifikasi notification) {
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
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy, HH:mm').format(notification.date),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
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
