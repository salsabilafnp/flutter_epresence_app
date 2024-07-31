import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/controller/auth_controller.dart';
import 'package:flutter_epresence_app/app/modules/models/kantor.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/app/modules/models/response/kantor_response.dart';
import 'package:flutter_epresence_app/app/modules/models/response/presensi_response.dart';
import 'package:flutter_epresence_app/app/modules/repository/presensi_repository.dart';
import 'package:flutter_epresence_app/services/geolocation_service.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:flutter_epresence_app/utils/routes.dart';
import 'package:get/get.dart';

class PresensiController extends GetxController {
  final AuthController _authController = Get.find();
  final PresensiRepository _presensiRepository = Get.put(PresensiRepository());
  final GeolocationService _geolocationService = Get.put(GeolocationService());

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
  Rx<Kantor?> detailKantor = Rx<Kantor?>(null);

  RxBool isPresensiHariIni = false.obs;
  RxBool isPulangHariIni = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLokasiValid = false.obs;
  RxString pesanLokasiValid = ''.obs;

  @override
  void onInit() {
    cekPresensiHariIni();
    getDetailKantor();
    if (_authController.user.value!.role == 'admin') {
      getSemuaPresensi();
      getRiwayatPresensi();
    } else {
      getRiwayatPresensi();
    }
    super.onInit();
  }

  // getRiwayatPresensi
  Future<void> getRiwayatPresensi() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final RiwayatPresensiResponse? response =
          await _presensiRepository.getRiwayatPresensi();

      if (response != null && response.daftarPresensi != null) {
        presensi.value = response.daftarPresensi!;
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

  // getSemuaPresensi()
  Future<void> getSemuaPresensi() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final RiwayatPresensiResponse? response =
          await _presensiRepository.getSemuaPresensi();
      if (response != null && response.daftarPresensi != null) {
        semuaPresensi.value = response.daftarPresensi!;
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

  // reloadData
  Future<void> reloadData() async {
    presensi.clear();
    if (_authController.user.value!.role == 'admin') {
      await getSemuaPresensi();
      await getRiwayatPresensi();
    } else {
      await getRiwayatPresensi();
    }
  }

  // filterPresensi
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
  Future<void> catatPresensiMasuk() async {
    try {
      if (isLokasiValid.value) {
        final response = await _presensiRepository.catatPresensiMasuk(
            _geolocationService.currentPosition.value!.latitude,
            _geolocationService.currentPosition.value!.longitude);

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
      } else {
        Get.snackbar(
          Dictionary.defaultError,
          pesanLokasiValid.value,
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

  // catatPresensiPulang(presensi)
  Future<void> catatPresesiPulang() async {
    try {
      if (isLokasiValid.value) {
        final response = await _presensiRepository.catatPresensiPulang(
            _geolocationService.currentPosition.value!.latitude,
            _geolocationService.currentPosition.value!.longitude);

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
      } else {
        Get.snackbar(
          Dictionary.defaultError,
          pesanLokasiValid.value,
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

  // detailPresensi(id)
  Future<void> getDetailPresensi(int id) async {
    try {
      final PresensiResponse? response =
          await _presensiRepository.getDetailPresensi(id);
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

  // detailKantor
  Future<void> getDetailKantor() async {
    const idKantor = 1;

    try {
      final KantorResponse? kantor =
          await _presensiRepository.getDetailKantor(idKantor);
      if (kantor != null) {
        detailKantor.value = kantor.kantor;
      }
    } catch (e) {
      Get.snackbar(
        Dictionary.defaultError,
        e.toString(),
        margin: const EdgeInsets.all(20),
      );
    }
  }

  // validasiLokasi()
  Future<void> validasiLokasi() async {
    final latitude = double.parse(detailKantor.value!.latitude!);
    final longitude = double.parse(detailKantor.value!.longitude!);
    final radiusInMeters = double.parse(detailKantor.value!.radiusKm!) * 1000;

    if (_geolocationService.isValidLocation(
        latitude, longitude, radiusInMeters)) {
      isLokasiValid.value = true;
      pesanLokasiValid.value =
          'Lokasi Anda berada di dalam area ${detailKantor.value!.name} (${detailKantor.value!.address}).';
    } else {
      isLokasiValid.value = false;
      pesanLokasiValid.value =
          'Lokasi Anda berada di luar area ${detailKantor.value!.name} (${detailKantor.value!.address}).';
    }
  }
}
