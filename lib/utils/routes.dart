import 'package:flutter_epresence_app/app/modules/views/karyawan/beranda_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/profil_view.dart';
import 'package:flutter_epresence_app/app/modules/views/login_view.dart';
import 'package:get/get.dart';

class RouteNames {
  static const logIn = '/login';
  static const bottomNavBar = '/bottom-navbar';
  static const homeStaff = '/home-staff';
  static const profile = '/profile';
}

class Routes {
  static final pages = [
    GetPage(
      name: RouteNames.logIn,
      page: () => LoginView(),
    ),
    GetPage(
      name: RouteNames.homeStaff,
      page: () => const BerandaView(),
    ),
    GetPage(
      name: RouteNames.profile,
      page: () => const ProfilView(),
    ),
  ];
}
