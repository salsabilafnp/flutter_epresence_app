import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';

class ProfilAdminView extends StatelessWidget {
  final User _adminUser = users[1];

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIdentityCard(context, _adminUser),
              const SizedBox(height: 50),
              FilledButton(
                onPressed: () {
                  Get.offAndToNamed(RouteNames.logIn);
                },
                style: AppTheme.secondaryButtonStyle,
                child: Text(Dictionary.logOut),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Get.offAndToNamed(RouteNames.aksesAdmin);
                },
                child: Text(Dictionary.gantiAkses),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityCard(BuildContext context, User userData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 35,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/${userData.imageUrl}'),
            ),
            const SizedBox(height: 15),
            Text(
              userData.nama,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 15),
            Text(userData.employeeType.toUpperCase()),
            const SizedBox(height: 5),
            Text('${userData.department} - ${userData.position}'),
            const SizedBox(height: 5),
            Text(userData.email),
            const SizedBox(height: 5),
            Text(userData.phoneNumber),
          ],
        ),
      ),
    );
  }
}
