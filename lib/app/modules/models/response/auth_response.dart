import 'package:flutter_epresence_app/app/modules/models/user.dart';

class AuthResponse {
  User? user;
  String? token;

  AuthResponse({
    this.user,
    this.token,
  });
  AuthResponse.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
    token = json['token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}
