import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavComponent extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomNavComponent({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      onTap: onTabTapped,
      currentIndex: currentIndex,
      elevation: 50,
      iconSize: 30,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      items: [
        _bottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: Dictionary.beranda,
        ),
        _bottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: Dictionary.profil,
        ),
      ],
    );
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

  Future<String> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? 'karyawan';
  }
}
