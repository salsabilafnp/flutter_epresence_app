import 'dart:developer';

import 'package:flutter_epresence_app/app/modules/models/response/attendances_response.dart';
import 'package:flutter_epresence_app/services/network_endpoint.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PresensiRepository extends GetConnect {
  final box = GetStorage();

  Future<AttendancesResponse?> getAttendanceUserHistory() async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.presensiRiwayat,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          return AttendancesResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error fetching attendance history: $e');
        rethrow;
      }
    }
    return null;
  }
}
