import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();
    splashCheck();
  }

  void splashCheck() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () => _authController.checkUserLogged(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ePresence',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              'Presensi Digital',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 100),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
