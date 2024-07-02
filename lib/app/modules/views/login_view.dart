import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_text_field.dart';
import 'package:flutter_epresence_app/utils/theme.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Text(
                      'ePresence',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
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
                    inputLabel: 'Email',
                  ),
                  CustomTextField(
                    inputLabel: 'Kata Sandi',
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  FilledButton(
                    style: AppTheme.primaryButtonStyle,
                    onPressed: () {},
                    child: const Text('Masuk'),
                  ),
                ],
              ),
              Text(
                'Jika Anda belum memiliki akun, silakan hubungi admin di kantor Anda.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
