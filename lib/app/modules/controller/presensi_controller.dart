import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/app/modules/models/response/presensi_response.dart';
import 'package:flutter_epresence_app/app/modules/repository/presensi_repository.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';

class PresensiController extends GetxController {
  final PresensiRepository _presensiRepository = Get.put(PresensiRepository());

  final TextEditingController tanggalAwal = TextEditingController();
  final TextEditingController tanggalAkhir = TextEditingController();

  RxList<PresensiNetwork?> presensi = RxList<PresensiNetwork?>([]);
  Rx<PresensiNetwork?> presensiHariIni = Rx<PresensiNetwork?>(null);
  RxList<RxBool> isExpandedList = RxList<RxBool>();
  Rx<DateTime?> dariTanggal = Rx<DateTime?>(null);
  Rx<DateTime?> sampaiTanggal = Rx<DateTime?>(null);
  RxList<PresensiNetwork?> presensiFilter = RxList<PresensiNetwork?>([]);

  RxBool isPresensiToday = false.obs;

  @override
  void onInit() {
    cekPresensiHariIni();
    getRiwayatPresensi();
    super.onInit();
  }

  // getRiwayatPresensi()
  Future<void> getRiwayatPresensi() async {
    try {
      final RiwayatPresensiResponse? riwayatPresensiResponse =
          await _presensiRepository.getRiwayatPresensi();
      if (riwayatPresensiResponse != null &&
          riwayatPresensiResponse.presensi != null) {
        presensi.value = riwayatPresensiResponse.presensi!;
        isExpandedList.value =
            List.generate(presensi.length, (index) => false.obs);
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

  // aturFilterPresensi
  void aturFilter(DateTime? start, DateTime? end) {
    dariTanggal.value = start;
    sampaiTanggal.value = end;
    _terapkanFilter();
  }

  // filtePresensi
  void _terapkanFilter() {
    if (dariTanggal.value != null && sampaiTanggal.value != null) {
      presensiFilter.value = presensi.where((attendance) {
        final attendanceDate = DateTime.parse(attendance!.date!);
        return attendanceDate
                .isAfter(dariTanggal.value!.subtract(Duration(days: 1))) &&
            attendanceDate
                .isBefore(sampaiTanggal.value!.add(Duration(days: 1)));
      }).toList();
    } else {
      presensiFilter.value = List.from(presensi);
    }
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
          isPresensiToday.value = true;
          presensiHariIni.value = response.presensi!;
        } else {
          isPresensiToday.value = false;
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

  // pengingatPresensi()
}
