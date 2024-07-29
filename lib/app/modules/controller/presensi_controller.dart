import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/app/modules/models/response/presensi_response.dart';
import 'package:flutter_epresence_app/app/modules/repository/presensi_repository.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:get/get.dart';

class PresensiController extends GetxController {
  final AuthController _authController = Get.find();
  final PresensiRepository _presensiRepository = Get.put(PresensiRepository());

  final TextEditingController tanggalAwal = TextEditingController();
  final TextEditingController tanggalAkhir = TextEditingController();

  RxList<Presensi?> presensi = RxList<Presensi?>([]);
  Rxn<PresensiResponse?> detailPresensi = Rxn<PresensiResponse?>();
  RxList<Presensi?> semuaPresensi = RxList<Presensi?>([]);
  Rx<Presensi?> presensiHariIni = Rx<Presensi?>(null);
  RxList<RxBool> isExpandedList = RxList<RxBool>();
  Rx<DateTime?> dariTanggal = Rx<DateTime?>(null);
  Rx<DateTime?> sampaiTanggal = Rx<DateTime?>(null);
  RxList<Presensi?> presensiFilter = RxList<Presensi?>([]);

  RxBool isPresensiHariIni = false.obs;
  RxBool isPulangHariIni = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    cekPresensiHariIni();
    loadData();
    super.onInit();
  }

  // loadData
  void loadData() {
    if (_authController.user.value!.role == 'admin') {
      getSemuaPresensi();
      getRiwayatPresensi();
    } else {
      getRiwayatPresensi();
    }
  }

  // getRiwayatPresensi
  Future<void> getRiwayatPresensi() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final RiwayatPresensiResponse? riwayatPresensiResponse =
          await _presensiRepository.getRiwayatPresensi();

      if (riwayatPresensiResponse != null &&
          riwayatPresensiResponse.presensi != null) {
        presensi.value = riwayatPresensiResponse.presensi!;
      }

      isExpandedList.value =
          List.generate(presensi.length, (index) => false.obs);
      _terapkanFilter();
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        e.toString(),
        margin: const EdgeInsets.all(20),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // reloadData
  Future<void> reloadData() async {
    presensi.clear();
    await getRiwayatPresensi();
    await getSemuaPresensi();
  }

  // filtePresensi
  void _terapkanFilter() {
    if (dariTanggal.value != null && sampaiTanggal.value != null) {
      presensiFilter.value = presensi.where((attendance) {
        final tanggalPresensi = DateTime.parse(attendance!.date!);
        return tanggalPresensi
                .isAfter(dariTanggal.value!.subtract(Duration(days: 1))) &&
            tanggalPresensi
                .isBefore(sampaiTanggal.value!.add(Duration(days: 1)));
      }).toList();
    } else {
      presensiFilter.value = List.from(presensi);
    }
  }

  // aturFilterPresensi
  void aturFilter(DateTime? start, DateTime? end) {
    dariTanggal.value = start;
    sampaiTanggal.value = end;
    _terapkanFilter();
  }

  // resetFilterPresensi
  void resetFilter() {
    dariTanggal.value = null;
    sampaiTanggal.value = null;
    _terapkanFilter();
  }

  // cek presensi hari ini
  Future<void> cekPresensiHariIni() async {
    try {
      final PresensiResponse? response =
          await _presensiRepository.cekPresensiHariIni();
      if (response != null) {
        if (response.presensi != null) {
          isPresensiHariIni.value = true;
          presensiHariIni.value = response.presensi!;
          if (response.presensi!.checkOutTime != null) {
            isPulangHariIni.value = true;
          }
        } else {
          isPresensiHariIni.value = false;
        }
      }
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        e.toString(),
        margin: const EdgeInsets.all(20),
      );
    }
  }

  // catatPresensiMasuk(presensi)
  Future<void> catatPresensiMasuk(double latitude, double longitude) async {
    try {
      final response =
          await _presensiRepository.catatPresensiMasuk(latitude, longitude);

      if (response!.presensi != null) {
        onInit();
        Get.back();
        Get.snackbar(
          Dictionary.defaultSuccess,
          Dictionary.suksesPresensiMasuk,
          margin: const EdgeInsets.all(20),
        );
        if (_authController.user.value!.role == 'admin') {
          Get.offAllNamed(RouteNames.bottomNavBar,
              parameters: {'role': Dictionary.staff});
        } else {
          _authController.cekRole();
        }
      }
    } catch (e) {
      Get.snackbar(
        Dictionary.gagalPresensiMasuk,
        e.toString(),
        margin: const EdgeInsets.all(20),
      );
    }
  }

  // catatPresensiKeluar(presensi)
  Future<void> catatPresensiKeluar(double latitude, double longitude) async {
    try {
      final response =
          await _presensiRepository.catatPresensiPulang(latitude, longitude);

      if (response != null) {
        onInit();
        Get.back();
        Get.snackbar(
          Dictionary.defaultSuccess,
          Dictionary.suksesPresensiPulang,
          margin: const EdgeInsets.all(20),
        );
        if (_authController.user.value!.role == 'admin') {
          Get.offAllNamed(RouteNames.bottomNavBar,
              parameters: {'role': Dictionary.staff});
        } else {
          _authController.cekRole();
        }
      }
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        Dictionary.gagalPresensiPulang,
        margin: const EdgeInsets.all(20),
      );
    }
  }

  // validasiLokasi()

  // getSemuaPresensi()
  Future<void> getSemuaPresensi() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final RiwayatPresensiResponse? response =
          await _presensiRepository.getSemuaPresensi();
      if (response != null && response.presensi != null) {
        semuaPresensi.value = response.presensi!;
      }
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        e.toString(),
        margin: const EdgeInsets.all(20),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // detailPresensi(id)
  Future<void> getDetailPresensi(int id) async {
    try {
      final PresensiResponse? response =
          await _presensiRepository.detailPresensi(id);
      if (response != null) {
        detailPresensi.value = response;
      } else {
        Get.snackbar(
          Dictionary.defaultError,
          'No data found',
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
}
