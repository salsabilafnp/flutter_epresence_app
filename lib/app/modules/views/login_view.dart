import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final AuthController _authController = Get.find();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 75),
                child: Column(
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
              ),
              Column(
                children: [
                  Text(
                    'Silakan masuk dengan akun yang telah terdaftar',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: _authController.email,
                    inputLabel: Dictionary.email,
                  ),
                  CustomTextField(
                    controller: _authController.kataSandi,
                    inputLabel: Dictionary.password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  FilledButton(
                    style: AppTheme.primaryButtonStyle,
                    onPressed: () {
                      _authController.login();
                    },
                    child: const Text(Dictionary.logIn),
                  ),
                ],
              ),
              Text(
                'Jika Anda belum memiliki akun, silakan hubungi admin di kantor Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
