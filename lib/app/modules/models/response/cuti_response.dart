import 'package:flutter_epresence_app/app/modules/models/cuti.dart';

class CutiResponse {
  Cuti? cuti;

  CutiResponse({
    this.cuti,
  });
  CutiResponse.fromJson(Map<String, dynamic> json) {
    cuti =
        (json['permission'] != null) ? Cuti.fromJson(json['permission']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (cuti != null) {
      data['permission'] = cuti!.toJson();
    }
    return data;
  }
}

class RiwayatCutiResponse {
  List<Cuti?>? cuti;

  RiwayatCutiResponse({
    this.cuti,
  });
  RiwayatCutiResponse.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      final v = json['permissions'];
      final arr0 = <Cuti>[];
      v.forEach((v) {
        arr0.add(Cuti.fromJson(v));
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
