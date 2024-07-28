import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/custom_bottom_navbar.dart';
import 'package:flutter_epresence_app/app/modules/controller/presensi_controller.dart';
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
  final bool isAdminAccessingAsStaff;

  const NavComponent({
    super.key,
    required this.role,
    this.isAdminAccessingAsStaff = false,
  });

  @override
  State<NavComponent> createState() => _NavComponentState();
}

class _NavComponentState extends State<NavComponent> {
  final PresensiController _presensiController = Get.put(PresensiController());

  int _tabIndex = 0;

  void changeTabIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showFloatingButton =
        widget.role == Dictionary.staff || widget.isAdminAccessingAsStaff;

    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: [
          // Views for staff
          if (widget.role == Dictionary.staff ||
              widget.isAdminAccessingAsStaff) ...[
            BerandaView(),
            ProfilView(isAdminAccessingAsStaff: widget.isAdminAccessingAsStaff),
          ],
          // Views for admin
          if (widget.role == Dictionary.admin &&
              !widget.isAdminAccessingAsStaff) ...[
            BerandaAdminView(),
            PresensiView(),
            CutiView(),
            ProfilAdminView(),
          ],
        ],
      ),
      bottomNavigationBar: CustomBottomNavbar(
        role: widget.role,
        isAdminAccessingAsStaff: widget.isAdminAccessingAsStaff,
        currentIndex: _tabIndex,
        onTabTapped: changeTabIndex,
      ),
      floatingActionButton:
          showFloatingButton || !_presensiController.isPulangHariIni.value
              ? Obx(() {
                  return FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(RouteNames.kameraPresensi);
                    },
                    shape: const CircleBorder(),
                    backgroundColor: _presensiController.isPresensiHariIni.value
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    child: const Icon(Symbols.familiar_face_and_zone),
                  );
                })
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
