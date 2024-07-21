import 'package:flutter_epresence_app/app/components/nav_component.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/akses_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/cuti_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/detail_cuti_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/detail_presensi_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/notifikasi_admin_view.dart';
import 'package:flutter_epresence_app/app/modules/views/admin/presensi_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/beranda_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/edit_cuti_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/kamera_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/notifikasi_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/pengajuan_cuti_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/profil_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/riwayat_cuti_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/riwayat_presensi_view.dart';
import 'package:flutter_epresence_app/app/modules/views/login_view.dart';
import 'package:flutter_epresence_app/app/modules/views/splash_screen.dart';
import 'package:get/get.dart';

class RouteNames {
  static const splashScreen = '/splash-screen';
  static const logIn = '/login';
  static const bottomNavBar = '/bottom-navbar';
  // staff routes
  static const berandaStaff = '/beranda-staff';
  static const notifStaff = '/notif-staff';
  static const kameraPresensi = '/kamera-presensi';
  static const lokasiPresensi = '/lokasi-presensi';
  static const kameraCuti = '/kamera-cuti';
  static const pengajuanCuti = '/pengajuan-cuti';
  static const editCuti = '/edit-cuti';
  static const riwayatPresensiStaff = '/riwayat-presensi-staff';
  static const riwayatCutiStaff = '/riwayat-cuti-staff';
  static const profilStaff = '/profile-staff';

  // admin routes
  static const aksesAdmin = '/akses-admin';
  static const berandaAdmin = '/beranda-admin';
  static const notifAdmin = '/notif-admin';
  static const riwayatPresensiAdmin = '/riwayat-presensi-admin';
  static const detailPresensi = '/detail-presensi';
  static const riwayatCutiAdmin = '/riwayat-cuti-admin';
  static const detailCuti = '/detail-cuti';
  static const profilAdmin = '/profile-admin';
  static const settingAdmin = '/setting-admin';
}

class Routes {
  static final pages = [
    // General
    GetPage(
      name: RouteNames.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteNames.logIn,
      page: () => LoginView(),
    ),
    GetPage(
      name: RouteNames.bottomNavBar,
      page: () {
        final role = Get.parameters['role'];
        return NavComponent(role: role!);
      },
    ),
    // For Staff
    GetPage(
      name: RouteNames.berandaStaff,
      page: () => BerandaView(),
    ),
    GetPage(
      name: RouteNames.notifStaff,
      page: () => NotifikasiView(),
    ),
    GetPage(
      name: RouteNames.riwayatPresensiStaff,
      page: () => RiwayatPresensiView(),
    ),
    GetPage(
      name: RouteNames.kameraPresensi,
      page: () => KameraView(
        showLocationCard: true,
      ),
    ),
    GetPage(
      name: RouteNames.riwayatCutiStaff,
      page: () => RiwayatCutiView(),
    ),
    GetPage(
      name: RouteNames.kameraCuti,
      page: () => KameraView(
        showLocationCard: false,
      ),
    ),
    GetPage(
      name: RouteNames.pengajuanCuti,
      page: () => PengajuanCutiView(),
    ),
    GetPage(
      name: RouteNames.editCuti,
      page: () => EditCutiView(),
    ),
    GetPage(
      name: RouteNames.profilStaff,
      page: () => ProfilView(),
    ),
    // For Admin
    GetPage(
      name: RouteNames.aksesAdmin,
      page: () => AksesView(),
    ),
    GetPage(
      name: RouteNames.notifAdmin,
      page: () => NotifikasiAdminView(),
    ),
    GetPage(
      name: RouteNames.riwayatPresensiAdmin,
      page: () => PresensiView(),
    ),
    GetPage(
      name: RouteNames.detailPresensi,
      page: () => DetailPresensiView(),
    ),
    GetPage(
      name: RouteNames.riwayatCutiAdmin,
      page: () => CutiView(),
    ),
    GetPage(
      name: RouteNames.detailCuti,
      page: () => DetailCutiView(),
    ),
  ];
}
