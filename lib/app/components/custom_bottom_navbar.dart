import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final String? role;
  final bool isAdminAccessingAsStaff;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
    this.role,
    this.isAdminAccessingAsStaff = false,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      onTap: onTabTapped,
      currentIndex: currentIndex,
      elevation: 50,
      iconSize: 30,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: role == Dictionary.admin && !isAdminAccessingAsStaff
          ? _buildAdminMenuItems()
          : _buildStaffMenuItems(),
    );
  }
}

List<BottomNavigationBarItem> _buildAdminMenuItems() {
  List<BottomNavigationBarItem> items = [
    _bottomNavigationBarItem(
      icon: const Icon(Symbols.home_rounded),
      label: Dictionary.beranda,
    ),
    _bottomNavigationBarItem(
      icon: const Icon(Icons.work_history_outlined),
      label: Dictionary.presensi,
    ),
    _bottomNavigationBarItem(
      icon: const Icon(Icons.edit_calendar_outlined),
      label: Dictionary.cuti,
    ),
    _bottomNavigationBarItem(
      icon: const Icon(Icons.person_outline),
      label: Dictionary.profil,
    ),
  ];

  return items;
}

List<BottomNavigationBarItem> _buildStaffMenuItems() {
  List<BottomNavigationBarItem> items = [
    _bottomNavigationBarItem(
      icon: const Icon(Symbols.home_rounded),
      label: Dictionary.beranda,
    ),
    _bottomNavigationBarItem(
      icon: const Icon(Icons.person_outline),
      label: Dictionary.profil,
    ),
  ];

  return items;
}

BottomNavigationBarItem _bottomNavigationBarItem({
  required Widget icon,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: icon,
    label: label,
  );
}
