import 'dart:developer';

import 'package:flutter_epresence_app/app/modules/models/request/permissions_request.dart';
import 'package:flutter_epresence_app/app/modules/models/response/permissions_response.dart';
import 'package:flutter_epresence_app/services/network_endpoint.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CutiRepository extends GetConnect {
  final box = GetStorage();

  Future<PermissionsResponse?> getRiwayatCuti() async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.cuti,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          return PermissionsResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error fetching riwayat cuti: $e');
        rethrow;
      }
    }
    return null;
  }

  Future<PermissionsResponse?> ajukanCuti(PermissionsRequest cuti) async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await post(
          NetworkEndpoint.cuti,
          headers: {'Authorization': 'Bearer $accessToken'},
          cuti.toJson(),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return PermissionsResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error creating cuti: $e');
        rethrow;
      }
    }
    return null;
  }

  Future<PermissionsResponse?> perbaruiCuti(
      int idCuti, PermissionsRequest cuti) async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await put(
          '${NetworkEndpoint.cuti}/$idCuti',
          headers: {'Authorization': 'Bearer $accessToken'},
          cuti.toJson(),
        );

        if (response.statusCode == 200) {
          return PermissionsResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error updating cuti: $e');
        rethrow;
      }
    }
    return null;
  }
}
