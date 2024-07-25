import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/models/rekapitulasi.dart';
import 'package:flutter_epresence_app/app/modules/models/response/auth_response.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/app/modules/repository/auth_repository.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository = Get.put(AuthRepository());

  final TextEditingController email = TextEditingController();
  final TextEditingController kataSandi = TextEditingController();

  Rx<RekapitulasiKaryawan?> rekapitulasiKaryawan =
      Rx<RekapitulasiKaryawan?>(null);
  Rx<RekapitulasiAdmin?> rekapitulasiAdmin = Rx<RekapitulasiAdmin?>(null);

  Rx<UserNetwork?> user = Rx<UserNetwork?>(null);
  final box = GetStorage();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  // loadData
  Future<void> loadData() async {
    try {
      await recapForAdmin();
      await recapForStaff();
      await loadUser();
    } catch (e) {
      Get.snackbar(Dictionary.defaultError, 'Gagal memuat data.');
    }
  }

  // login
  Future<void> login() async {
    try {
      final AuthResponse? authResponse =
          await authRepository.login(email.text, kataSandi.text);

      if (authResponse != null && authResponse.token != null) {
        // cek role
        final String role = authResponse.user?.role ?? '';

        // Simpan informasi user di GetStorage
        box.write('user', authResponse.user?.toJson());
        loadUser();

        // final user = box.read('user');

        // if (user['face_embedding'] == null) {
        //   // Redirect to face registration page
        //   Get.offAllNamed(RouteNames.registrasiWajah);
        // } else {
        // Redirect ke halaman sesuai role
        if (role == 'admin') {
          Get.offAllNamed(
            RouteNames.bottomNavBar,
            parameters: {'role': Dictionary.admin},
          );
        } else if (role == 'staff') {
          Get.offAllNamed(
            RouteNames.bottomNavBar,
            parameters: {'role': Dictionary.staff},
          );
        } else {
          Get.snackbar(
            Dictionary.defaultError,
            'Role tidak dikenal',
            margin: const EdgeInsets.all(20),
          );
        }

        Get.snackbar(
          Dictionary.defaultSuccess,
          Dictionary.suksesLogin,
          margin: const EdgeInsets.all(20),
        );
        // }
      } else {
        Get.snackbar(
          Dictionary.defaultError,
          Dictionary.gagalLogin,
          margin: const EdgeInsets.all(20),
        );
      }
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        e.toString(),
        margin: const EdgeInsets.all(20),
      );
    }
  }

  // checkUserLogged
  Future<void> checkUserLogged() async {
    final String? token = box.read('token');
    final user = box.read('user');

    if (token != null && user != null) {
      cekRole();
    } else {
      Get.offAllNamed(RouteNames.logIn);
    }
  }

  // loadUser
  Future<void> loadUser() async {
    final userData = box.read('user');
    if (userData != null) {
      user.value = UserNetwork.fromJson(userData);
    }
  }

  // updateProfil
  Future<void> updateProfil(String faceEmbedding, String imageUrl) async {
    try {
      await authRepository.updateProfil(faceEmbedding, imageUrl);
      Get.snackbar(Dictionary.defaultSuccess, "Profil berhasil diperbarui.");
    } catch (e) {
      Get.snackbar(Dictionary.defaultError, "Gagal memperbarui profil.");
      print(e);
    }
  }

  // verifikasiWajah

  // rekapitulasiKaryawan
  Future<void> recapForStaff() async {
    try {
      final rekapKaryawan = await authRepository.recapForStaff();
      rekapitulasiKaryawan.value = rekapKaryawan;
      print(rekapKaryawan);
    } catch (e) {
      Get.snackbar(
          Dictionary.defaultError, "Gagal mendapatkan rekap presensi.");
      print(e);
    }
  }

  // rekapitulasiAdmin
  Future<void> recapForAdmin() async {
    try {
      final rekapAdmin = await authRepository.recapForAdmin();
      rekapitulasiAdmin.value = rekapAdmin;
      print(rekapAdmin);
    } catch (e) {
      Get.snackbar(
          Dictionary.defaultError, "Gagal mendapatkan rekap presensi.");
      print(e);
    }
  }

  // logout
  Future<void> logout() async {
    try {
      await authRepository.logout();
      Get.offAllNamed(RouteNames.logIn);
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        'Gagal logout: $e',
        margin: const EdgeInsets.all(20),
      );
    }
  }

  void cekRole() {
    final userData = box.read('user');
    final role = userData['role'];

    if (role == 'admin') {
      Get.offAllNamed(
        RouteNames.bottomNavBar,
        parameters: {'role': Dictionary.admin},
      );
    } else if (role == 'staff') {
      Get.offAllNamed(
        RouteNames.bottomNavBar,
        parameters: {'role': Dictionary.staff},
      );
    }
  }
}
