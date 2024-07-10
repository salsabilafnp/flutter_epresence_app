import 'dart:developer';

import 'package:flutter_epresence_app/app/modules/models/response/auth_response.dart';
import 'package:flutter_epresence_app/app/modules/models/user.dart';
import 'package:flutter_epresence_app/services/network_endpoint.dart';
import 'package:flutter_epresence_app/utils/dictionary.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepository extends GetConnect {
  final box = GetStorage();

  Future<AuthResponse?> login(String email, String password) async {
    try {
      final response = await post(
        NetworkEndpoint.login,
        {
          'email': email,
          'password': password,
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

  Future<UserNetwork?> userProfile() async {
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
}
