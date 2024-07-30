import 'dart:developer';

import 'package:flutter_epresence_app/app/modules/models/cuti.dart';
import 'package:flutter_epresence_app/app/modules/models/request/cuti_request.dart';
import 'package:flutter_epresence_app/app/modules/models/response/cuti_response.dart';
import 'package:flutter_epresence_app/services/network_endpoint.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CutiRepository extends GetConnect {
  final box = GetStorage();

  // getRiwayatCuti()
  Future<RiwayatCutiResponse?> getRiwayatCuti() async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.cuti,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          return RiwayatCutiResponse.fromJson(response.body);
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

  // ajukanCuti(cuti)
  Future<RiwayatCutiResponse?> ajukanCuti(CutiRequest cuti) async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await post(
          NetworkEndpoint.cuti,
          headers: {'Authorization': 'Bearer $accessToken'},
          cuti.toJson(),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return RiwayatCutiResponse.fromJson(response.body);
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

  // perbaruiCuti(cuti)
  Future<RiwayatCutiResponse?> perbaruiCuti(
      int idCuti, CutiRequest cuti) async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await put(
          '${NetworkEndpoint.cuti}/$idCuti',
          headers: {'Authorization': 'Bearer $accessToken'},
          cuti.toJson(),
        );

        if (response.statusCode == 200) {
          return RiwayatCutiResponse.fromJson(response.body);
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

  // getSemuaCuti()
  Future<RiwayatCutiResponse?> getSemuaCuti() async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.cutiSemuaRiwayat,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          return RiwayatCutiResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error fetching all cuti(s) history: $e');
        rethrow;
      }
    }
    return null;
  }

  // getDetailAjuan(id)
  Future<CutiResponse?> getDetailAjuan(int id) async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          '${NetworkEndpoint.cuti}/$id',
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          return CutiResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error fetching detail cuti: $e');
        rethrow;
      }
    }
    return null;
  }

  // konfirmasiAjuan(id, status)
  Future<Cuti?> konfirmasiAjuan(int id, String status) async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await post(
          '${NetworkEndpoint.cutiKonfirmasi}/$id',
          headers: {'Authorization': 'Bearer $accessToken'},
          ({'status': status}),
        );

        if (response.statusCode == 200) {
          return Cuti.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error confirming cuti: $e');
        rethrow;
      }
    }
    return null;
  }

  // notifAjuanBaru()

  // notifAjuanDitindaklanjuti()
}
