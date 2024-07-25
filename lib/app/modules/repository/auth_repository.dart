import 'dart:developer';

import 'package:flutter_epresence_app/app/modules/models/rekapitulasi.dart';
import 'package:flutter_epresence_app/app/modules/models/response/auth_response.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/services/network_endpoint.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepository extends GetConnect {
  final box = GetStorage();

  // login(email, kataSandi)
  Future<AuthResponse?> login(String email, String kataSandi) async {
    try {
      final response = await post(
        NetworkEndpoint.login,
        {
          'email': email,
          'password': kataSandi,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.body['token'];
        final user = response.body['user'];

        box.write('token', accessToken);
        box.write('user', user);

        log(accessToken);
        log(response.body.toString());

        return AuthResponse.fromJson(response.body);
      } else {
        if (response.statusCode == 403) {
          final errorMessage = response.body['message'];
          throw errorMessage;
        } else {
          throw Dictionary.defaultError;
        }
      }
    } catch (e) {
      inspect('Terjadi kesalahan saat login: $e');
      rethrow;
    }
  }

  // userProfil()
  Future<UserNetwork?> userProfil() async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.profile,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          return UserNetwork.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        inspect('Terjadi kesalahan saat melihat informasi user: $e');
        rethrow;
      }
    }
    return null;
  }

  // logout()
  Future<void> logout() async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await post(
          NetworkEndpoint.logout,
          {},
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          await box.erase();
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        inspect('Terjadi kesalahan saat logout: $e');
        rethrow;
      }
    }
  }

  // updateProfil(faceEmbedding, imageUrl)
  Future<void> updateProfil(String faceEmbedding, String imageUrl) async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await put(
          NetworkEndpoint.updateProfile,
          {
            'face_embedding': faceEmbedding,
            'image_url': imageUrl,
          },
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          final user = response.body['user'];
          box.write('user', user);
          // return UserNetwork.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        inspect('Terjadi kesalahan saat mengupdate profil: $e');
        rethrow;
      }
    }
  }

  // recapForStaff
  Future<RekapitulasiKaryawan?> recapForStaff() async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.rekapKaryawan,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          log(response.body.toString());
          return RekapitulasiKaryawan.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        inspect('Terjadi kesalahan saat melihat rekap presensi karyawan: $e');
        rethrow;
      }
    }
    return null;
  }

  // recapForAdmin
  Future<RekapitulasiAdmin?> recapForAdmin() async {
    final String? accessToken = box.read('token');

    if (accessToken != null) {
      try {
        final response = await get(
          NetworkEndpoint.rekapAdmin,
          headers: {'Authorization': 'Bearer $accessToken'},
        );

        if (response.statusCode == 200) {
          log(response.body.toString());
          return RekapitulasiAdmin.fromJson(response.body);
        } else {
          throw Dictionary.defaultError;
        }
      } catch (e) {
        inspect('Terjadi kesalahan saat melihat rekap presensi admin: $e');
        rethrow;
      }
    }
    return null;
  }
}
