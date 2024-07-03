import 'package:flutter_epresence_app/app/modules/views/karyawan/beranda_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/notifikasi_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/pengajuan_cuti_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/profil_view.dart';
import 'package:flutter_epresence_app/app/modules/views/karyawan/riwayat_presensi_view.dart';
import 'package:flutter_epresence_app/app/modules/views/login_view.dart';
import 'package:get/get.dart';

class RouteNames {
  static const logIn = '/login';
  static const bottomNavBar = '/bottom-navbar';
  static const berandaStaff = '/beranda-staff';
  static const notifStaff = '/notif-staff';
  static const kameraPresensi = '/kamera-presensi';
  static const lokasiPresensi = '/lokasi-presensi';
  static const kameraCuti = '/kamera-cuti';
  static const pengajuanCuti = '/pengajuan-cuti';
  static const riwayatPresensiStaff = '/riwayat-presensi-staff';
  static const riwayatCutiStaff = '/riwayat-cuti-staff';
  static const profilStaff = '/profile-staff';
}

class Routes {
  static final pages = [
    GetPage(
      name: RouteNames.logIn,
      page: () => LoginView(),
    ),
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
      name: RouteNames.pengajuanCuti,
      page: () => PengajuanCutiView(),
    ),
    GetPage(
      name: RouteNames.profilStaff,
      page: () => ProfilView(),
    ),
  ];
}
