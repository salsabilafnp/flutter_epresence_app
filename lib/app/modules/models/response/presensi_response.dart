import 'package:flutter_epresence_app/app/modules/models/presensi.dart';

class PresensiResponse {
  String? pesan;
  Presensi? presensi;

  PresensiResponse({
    this.pesan,
    this.presensi,
  });

  PresensiResponse.fromJson(Map<String, dynamic> json) {
    pesan = json['message']?.toString();
    presensi = (json['attendance'] != null && (json['attendance'] is Map))
        ? Presensi.fromJson(json['attendance'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = pesan;
    if (presensi != null) {
      data['attendance'] = presensi!.toJson();
    }
    return data;
  }
}

class RiwayatPresensiResponse {
  List<Presensi?>? daftarPresensi;

  RiwayatPresensiResponse({
    this.daftarPresensi,
  });

  RiwayatPresensiResponse.fromJson(Map<String, dynamic> json) {
    if (json['attendances'] != null) {
      final v = json['attendances'];
      final arr0 = <Presensi>[];
      v.forEach((v) {
        arr0.add(Presensi.fromJson(v));
      });
      daftarPresensi = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (daftarPresensi != null) {
      final v = daftarPresensi;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['attendances'] = arr0;
    }
    return data;
  }
}
