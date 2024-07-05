import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/notifikasi.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:intl/intl.dart';

class NotifikasiView extends StatelessWidget {
  final List<Notifikasi> _staffNotifications =
      notifications.where((notifikasi) => notifikasi.isForStaff).toList();

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
          itemCount: _staffNotifications.length,
          itemBuilder: (context, index) {
            return _buildNotificationCard(context, _staffNotifications[index]);
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
