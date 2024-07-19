import 'package:flutter/material.dart';
import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/app/modules/models/request/cuti_request.dart';
import 'package:flutter_epresence_app/app/modules/models/response/cuti_response.dart';
import 'package:flutter_epresence_app/app/modules/repository/cuti_repository.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';

class CutiController extends GetxController {
  final CutiRepository _cutiRepository = Get.put(CutiRepository());

  final TextEditingController tanggalAwal = TextEditingController();
  final TextEditingController tanggalAkhir = TextEditingController();

  final TextEditingController jenisAjuanController = TextEditingController();
  final TextEditingController tanggalCutiController = TextEditingController();
  final TextEditingController durasiController = TextEditingController();
  final TextEditingController alasanController = TextEditingController();
  final TextEditingController buktiFileController = TextEditingController();
  final TextEditingController statusAjuanController = TextEditingController();
  final TextEditingController waktuPengajuanController =
      TextEditingController();

  RxList<CutiNetwork?> cuti = RxList<CutiNetwork?>([]);
  Rx<DateTime?> dariTanggal = Rx<DateTime?>(null);
  Rx<DateTime?> sampaiTanggal = Rx<DateTime?>(null);
  RxList<CutiNetwork?> cutiFilter = RxList<CutiNetwork?>([]);

  RxString? selectedPermitType = 'Semua'.obs;
  RxString? selectedStatus = 'Semua'.obs;

  @override
  void onInit() {
    super.onInit();
    getRiwayatCuti();
  }

  // getRiwayatCuti()
  Future<void> getRiwayatCuti() async {
    try {
      final CutiResponse? cutiResponse = await _cutiRepository.getRiwayatCuti();
      if (cutiResponse != null && cutiResponse.cuti != null) {
        cuti.value = cutiResponse.cuti!;
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

  // filterCuti
  void _terapkanFilter() {
    List<CutiNetwork?> tempList = cuti;

    if (dariTanggal.value != null && sampaiTanggal.value != null) {
      tempList = tempList.where((permit) {
        final permitDate = DateTime.parse(permit!.leaveDate!);
        return permitDate.isAfter(
                dariTanggal.value!.subtract(const Duration(days: 1))) &&
            permitDate
                .isBefore(sampaiTanggal.value!.add(const Duration(days: 1)));
      }).toList();
    }

    if (selectedPermitType!.value != 'Semua') {
      tempList = tempList.where((permit) {
        return Dictionary.mapTipe(permit!.permitType!) ==
            selectedPermitType!.value;
      }).toList();
    }

    if (selectedStatus!.value != 'Semua') {
      tempList = tempList.where((permit) {
        return Dictionary.mapStatus(permit!.status!) == selectedStatus!.value;
      }).toList();
    }

    cutiFilter.value = tempList;
  }

  // aturFilterCuti
  void aturFilter(
      DateTime? start, DateTime? end, String? permitType, String? status) {
    dariTanggal.value = start;
    sampaiTanggal.value = end;
    selectedPermitType!.value = permitType!;
    selectedStatus!.value = status!;
    _terapkanFilter();
  }

  // ajukanCuti
  Future<void> ajukanCuti() async {
    try {
      final CutiResponse? cutiResponse = await _cutiRepository.ajukanCuti(
        PermissionsRequest(
          leaveDate: tanggalCutiController.text,
          permitType: jenisAjuanController.text,
          duration: int.parse(durasiController.text),
          fileUrl: buktiFileController.text,
          reason: alasanController.text,
          status: statusAjuanController.text,
        ),
      );

      if (cutiResponse != null) {
        getRiwayatCuti();
        Get.back();
        Get.snackbar(
          Dictionary.defaultSuccess,
          Dictionary.suksesAjuanCuti,
          margin: const EdgeInsets.all(20),
        );
      } else {
        Get.snackbar(
          Dictionary.defaultError,
          Dictionary.gagalAjuanCuti,
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

  // perbaruiCuti(cuti)
  Future<void> perbaruiCuti(int idCuti) async {
    try {
      final CutiResponse? cutiResponse = await _cutiRepository.perbaruiCuti(
        idCuti,
        PermissionsRequest(
          leaveDate: tanggalCutiController.text,
          permitType: jenisAjuanController.text,
          duration: int.parse(durasiController.text),
          fileUrl: buktiFileController.text,
          reason: alasanController.text,
          status: statusAjuanController.text,
        ),
      );

      if (cutiResponse != null) {
        getRiwayatCuti();
        Get.back();
        Get.snackbar(
          Dictionary.defaultSuccess,
          Dictionary.suksesUbahCuti,
          margin: const EdgeInsets.all(20),
        );
      } else {
        Get.snackbar(
          Dictionary.defaultError,
          Dictionary.gagalUbahCuti,
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

  // getSemuaCuti()

  // getDetailAjuan(id)

  // konfirmasiAjuan(id, status)

  // notifAjuanBaru()

  // notifAjuanDitindaklanjuti()
}
