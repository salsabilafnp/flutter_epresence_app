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
          final timeFormat = DateFormat('HH:mm:ss');
          final dateFormat = DateFormat.yMMMMEEEEd();

          final formattedTime = timeFormat.format(currentTime);
          final formattedDate = dateFormat.format(currentTime);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              Text(
                formattedTime,
                style: Theme.of(context).textTheme.headlineLarge,
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
