import 'package:flutter_epresence_app/app/modules/models/cuti.dart';

class CutiResponse {
  List<CutiNetwork?>? cuti;

  CutiResponse({
    this.cuti,
  });
  CutiResponse.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      final v = json['permissions'];
      final arr0 = <CutiNetwork>[];
      v.forEach((v) {
        arr0.add(CutiNetwork.fromJson(v));
      });
      cuti = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (cuti != null) {
      final v = cuti;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['permissions'] = arr0;
    }
    return data;
  }
}
