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
  List<Cuti?>? daftarCuti;

  RiwayatCutiResponse({
    this.daftarCuti,
  });
  RiwayatCutiResponse.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      final v = json['permissions'];
      final arr0 = <Cuti>[];
      v.forEach((v) {
        arr0.add(Cuti.fromJson(v));
      });
      daftarCuti = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (daftarCuti != null) {
      final v = daftarCuti;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['permissions'] = arr0;
    }
    return data;
  }
}
