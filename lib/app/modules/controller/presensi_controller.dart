import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/app/modules/models/response/presensi_response.dart';
import 'package:flutter_epresence_app/app/modules/repository/presensi_repository.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';

class PresensiController extends GetxController {
  final AuthController _authController = Get.find();
  final PresensiRepository _presensiRepository = Get.put(PresensiRepository());

  final TextEditingController tanggalAwal = TextEditingController();
  final TextEditingController tanggalAkhir = TextEditingController();

  RxList<PresensiNetwork?> presensi = RxList<PresensiNetwork?>([]);
  Rx<PresensiNetwork?> presensiHariIni = Rx<PresensiNetwork?>(null);
  RxList<RxBool> isExpandedList = RxList<RxBool>();
  Rx<DateTime?> dariTanggal = Rx<DateTime?>(null);
  Rx<DateTime?> sampaiTanggal = Rx<DateTime?>(null);
  RxList<PresensiNetwork?> presensiFilter = RxList<PresensiNetwork?>([]);

  RxBool isPresensiHariIni = false.obs;
  RxBool isPulangHariIni = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    cekPresensiHariIni();
    getRiwayatPresensi();
    super.onInit();
  }

  // getRiwayatPresensi dengan paginasi
  Future<void> getRiwayatPresensi({bool isLoadMore = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final RiwayatPresensiResponse? riwayatPresensiResponse =
          await _presensiRepository.getRiwayatPresensi();

      if (riwayatPresensiResponse != null &&
          riwayatPresensiResponse.presensi != null) {
        if (isLoadMore) {
          presensi.addAll(riwayatPresensiResponse.presensi!);
        } else {
          presensi.value = riwayatPresensiResponse.presensi!;
        }
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
          if (response.presensi!.checkOutTime == null) {
            isPulangHariIni.value = false;
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
        _authController.cekRole();
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
        _authController.cekRole();
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
    try {
      final RiwayatPresensiResponse? semuaPresensiResponse =
          await _presensiRepository.getSemuaPresensi();
      if (semuaPresensiResponse != null &&
          semuaPresensiResponse.presensi != null) {
        presensi.value = semuaPresensiResponse.presensi!;
        _terapkanFilter();
      }
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        e.toString(),
        margin: const EdgeInsets.all(20),
      );
    }
  }

  // detailPresensi()

  // pengingatPresensi()
}
