import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'time_controller.dart';

class TimeDateDisplay extends StatelessWidget {
  final TimeController timeController = Get.put(TimeController());

  TimeDateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: timeController.timeStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final currentTime = snapshot.data!;
          final timeFormat = DateFormat.Hms('id_ID');
          final dateFormat = DateFormat.yMMMMEEEEd('id_ID');

          final formattedTime = timeFormat.format(currentTime);
          final formattedDate = dateFormat.format(currentTime);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
