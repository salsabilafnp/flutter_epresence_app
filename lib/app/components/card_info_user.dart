import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:get/get.dart';

class CardInfoUser extends StatelessWidget {
  const CardInfoUser({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.employeeType!.capitalize!),
                    const SizedBox(height: 10),
                    Text('${user.department} - ${user.position}'),
                    const SizedBox(height: 10),
                    Text(user.email!),
                    const SizedBox(height: 10),
                    Text(
                      user.phoneNumber ?? 'Nomor HP belum tercatat',
                      style: TextStyle(
                        fontStyle: user.phoneNumber == null
                            ? FontStyle.italic
                            : FontStyle.normal,
                        color: user.phoneNumber == null
                            ? Theme.of(context).disabledColor
                            : Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
