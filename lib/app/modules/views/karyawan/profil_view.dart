import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:flutter_epresence_app/utils/theme.dart';
import 'package:get/get.dart';

class ProfilView extends StatelessWidget {
  final User _staffUser = users[0];

  ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageTitle: Dictionary.profil,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIdentityCard(context, _staffUser),
              const SizedBox(height: 30),
              _buildAttendanceSummaryCard(context),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: () {
                  Get.offAndToNamed(RouteNames.logIn);
                },
                style: AppTheme.secondaryButtonStyle,
                child: Text(Dictionary.logOut),
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
          vertical: 25,
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

  Widget _buildAttendanceSummaryCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Rekapitulasi Presensi',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Hadir',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text('20 hari'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Sakit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text('20 hari'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Cuti',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text('20 hari'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'WFH',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text('20 hari'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
