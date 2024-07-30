import 'dart:developer';

import 'package:flutter_epresence_app/app/modules/models/response/kantor_response.dart';
import 'package:flutter_epresence_app/app/modules/models/response/presensi_response.dart';
import 'package:flutter_epresence_app/services/network_endpoint.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PresensiRepository extends GetConnect {
  final box = GetStorage();

  // getRiwayatPresensi
  Future<RiwayatPresensiResponse?> getRiwayatPresensi() async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.presensiRiwayat,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          return RiwayatPresensiResponse.fromJson(response.body);
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

  // cekPresensiHariIni
  Future<PresensiResponse?> cekPresensiHariIni() async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.presensiHariIni,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          return PresensiResponse.fromJson(response.body);
        } else {
          throw response.body;
        }
      } catch (e) {
        log('Error checking in: $e');
        rethrow;
      }
    }

    return null;
  }

  // catatPresensiMasuk(presensi)
  Future<PresensiResponse?> catatPresensiMasuk(
      double latitude, double longitude) async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await post(
          NetworkEndpoint.presensiCheckIn,
          ({
            'latitude': latitude,
            'longitude': longitude,
          }),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          return PresensiResponse.fromJson(response.body);
        } else {
          throw response.body;
        }
      } catch (e) {
        log('Error checking in: $e');
        rethrow;
      }
    }

    return null;
  }

  // catatPresensiKeluar(presensi)
  Future<PresensiResponse?> catatPresensiPulang(
      double latitude, double longitude) async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await post(
          NetworkEndpoint.presensiCheckOut,
          ({
            'latitude': latitude,
            'longitude': longitude,
          }),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          return PresensiResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error checking out: $e');
        rethrow;
      }
    }

    return null;
  }

  // validasiLokasi()

  // getSemuaPresensi()
  Future<RiwayatPresensiResponse?> getSemuaPresensi() async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.presensiSemuaRiwayat,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          return RiwayatPresensiResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error fetching all attendance history: $e');
        rethrow;
      }
    }
    return null;
  }

  // getDetailPresensi(id)
  Future<PresensiResponse?> getDetailPresensi(int id) async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          '${NetworkEndpoint.presensi}/$id',
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          return PresensiResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error fetching detail attendance $id: $e');
        rethrow;
      }
    }
    return null;
  }

  // pengingatPresensi()

  // getDetailKantor($id)
  Future<KantorResponse?> getDetailKantor(int id) async {
    final String? accessToken = box.read('token');
    if (accessToken != null) {
      try {
        final response = await get(
          '${NetworkEndpoint.kantor}/$id',
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          return KantorResponse.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        log('Error fetching office detail: $e');
        rethrow;
      }
    }
    return null;
  }
}
