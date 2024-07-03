import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/components/bottom_nav_component.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/beranda_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/profil_view.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class NavComponent extends StatefulWidget {
  const NavComponent({super.key});

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

  void onFabTapped() {
    setState(() {
      _tabIndex = 1; // Pindah ke tab "Catat Presensi" saat FAB ditekan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: const [
          BerandaView(),
          ProfilView(),
        ],
      ),
      bottomNavigationBar: BottomNavComponent(
        currentIndex: _tabIndex,
        onTabTapped: changeTabIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Symbols.familiar_face_and_zone),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
