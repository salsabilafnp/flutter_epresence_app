import 'package:flutter_epresence_app/app/modules/models/cuti.dart';

class PermissionsResponse {
  List<CutiNetwork?>? permissions;

  PermissionsResponse({
    this.permissions,
  });
  PermissionsResponse.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      final v = json['permissions'];
      final arr0 = <CutiNetwork>[];
      v.forEach((v) {
        arr0.add(CutiNetwork.fromJson(v));
      });
      permissions = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (permissions != null) {
      final v = permissions;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['permissions'] = arr0;
    }
    return data;
  }
}
