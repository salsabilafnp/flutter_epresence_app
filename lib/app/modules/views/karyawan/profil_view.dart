import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_app_bar.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/theme.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        pageTitle: Dictionary.profil,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIdentityCard(context),
              const SizedBox(height: 30),
              _buildAttendanceSummaryCard(context),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: () {},
                style: AppTheme.secondaryButtonStyle,
                child: Text(Dictionary.logOut),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const SizedBox(height: 15),
            Text(
              'Nama Lengkap dari Karyawan',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 15),
            Text('Tipe Pekerja'),
            const SizedBox(height: 5),
            Text('Departemen - Posisi'),
            const SizedBox(height: 5),
            Text('Email'),
            const SizedBox(height: 5),
            Text('No. Handphone'),
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
