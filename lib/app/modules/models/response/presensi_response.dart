import 'package:flutter_epresence_app/app/modules/models/presensi.dart';

class PresensiResponse {
  List<PresensiNetwork?>? presensi;

  PresensiResponse({
    this.presensi,
  });
  PresensiResponse.fromJson(Map<String, dynamic> json) {
    if (json['attendances'] != null) {
      final v = json['attendances'];
      final arr0 = <PresensiNetwork>[];
      v.forEach((v) {
        arr0.add(PresensiNetwork.fromJson(v));
      });
      presensi = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (presensi != null) {
      final v = presensi;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['attendances'] = arr0;
    }
    return data;
  }
}
