import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/models/presensi.dart';
import 'package:flutter_epresence_app/app/modules/models/response/attendances_response.dart';
import 'package:flutter_epresence_app/app/modules/repository/karyawan/presensi_repository.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';

class PresensiController extends GetxController {
  final PresensiRepository _presensiRepository = Get.put(PresensiRepository());

  final TextEditingController tanggalAwal = TextEditingController();
  final TextEditingController tanggalAkhir = TextEditingController();

  RxList<PresensiNetwork?> presensi = RxList<PresensiNetwork?>([]);
  RxList<RxBool> isExpandedList = RxList<RxBool>();
  Rx<DateTime?> dariTanggal = Rx<DateTime?>(null);
  Rx<DateTime?> sampaiTanggal = Rx<DateTime?>(null);
  RxList<PresensiNetwork?> presensiFilter = RxList<PresensiNetwork?>([]);

  @override
  void onInit() {
    super.onInit();
    fetchRiwayatPresensi();
  }

  Future<void> fetchRiwayatPresensi() async {
    try {
      final AttendancesResponse? attendanceResponse =
          await _presensiRepository.getRiwayatPresensi();
      if (attendanceResponse != null && attendanceResponse.presensi != null) {
        presensi.value = attendanceResponse.presensi!;
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

  void aturFilter(DateTime? start, DateTime? end) {
    dariTanggal.value = start;
    sampaiTanggal.value = end;
    _terapkanFilter();
  }
}
