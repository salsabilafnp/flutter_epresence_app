import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';

class AksesView extends StatelessWidget {
  const AksesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'ePresence',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Text(
                    'Presensi Digital',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Pilih akses yang ingin digunakan',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 50),
                  FilledButton(
                    style: AppTheme.primaryButtonStyle,
                    onPressed: () {
                      Get.offAllNamed(
                        RouteNames.bottomNavBar,
                        parameters: {'role': Dictionary.admin},
                      );
                    },
                    child: Text(Dictionary.admin),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    style: AppTheme.secondaryButtonStyle,
                    onPressed: () {
                      Get.offAllNamed(
                        RouteNames.bottomNavBar,
                        parameters: {
                          'role': Dictionary.admin,
                          'isAdminAccessingAsStaff': 'true',
                        },
                      );
                    },
                    child: Text(Dictionary.staff),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
