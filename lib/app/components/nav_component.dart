import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_bottom_navbar.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/beranda_admin_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/cuti_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/presensi_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/profil_admin_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/beranda_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/profil_view.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class NavComponent extends StatefulWidget {
  final String role;

  const NavComponent({super.key, required this.role});

  @override
  State<NavComponent> createState() => _NavComponentState();
}

class _NavComponentState extends State<NavComponent> {
  int _tabIndex = 0;

  void changeTabIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: [
          // Views for staff
          if (widget.role == Dictionary.staff) ...[
            BerandaView(),
            ProfilView(),
          ],
          // Views for admin
          if (widget.role == Dictionary.admin) ...[
            BerandaAdminView(),
            PresensiView(),
            CutiView(),
            ProfilAdminView(),
          ],
        ],
      ),
      bottomNavigationBar: CustomBottomNavbar(
        role: widget.role,
        currentIndex: _tabIndex,
        onTabTapped: changeTabIndex,
      ),
      floatingActionButton: widget.role == Dictionary.staff
          ? FloatingActionButton(
              onPressed: () {
                Get.toNamed(RouteNames.kameraPresensi);
              },
              shape: const CircleBorder(),
              child: const Icon(Symbols.familiar_face_and_zone),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
