import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';

class ProfilAdminView extends StatelessWidget {
  final AuthController _authController = Get.find();

  ProfilAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.profil,
        role: Dictionary.admin,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Obx(
            () {
              User? userData = _authController.user.value;

              if (userData != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIdentitas(context, userData),
                    const SizedBox(height: 30),
                    FilledButton(
                      onPressed: () {
                        _authController.logout();
                      },
                      style: AppTheme.secondaryButtonStyle,
                      child: const Text(Dictionary.logOut),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        Get.offAndToNamed(RouteNames.aksesAdmin);
                      },
                      child: Text(Dictionary.gantiAkses),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIdentitas(BuildContext context, User userData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/images/${userData.imageUrl ?? 'avatar2.png'}'),
            ),
            const SizedBox(height: 15),
            Text(
              userData.name ?? 'Nama Pengguna',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
            const SizedBox(height: 15),
            Text(userData.employeeType?.toUpperCase() ?? 'Non Pengguna'),
            const SizedBox(height: 5),
            Text('${userData.department} - ${userData.position}'),
            const SizedBox(height: 5),
            Text(userData.email ?? 'Email belum terdaftar'),
            const SizedBox(height: 5),
            Text(userData.phoneNumber ?? 'Nomor HP belum terdaftar'),
          ],
        ),
      ),
    );
  }
}
