import 'package:flutter_epresence_app/app/modules/models/kantor.dart';

class KantorResponse {
  String? pesan;
  Kantor? kantor;

  KantorResponse({
    this.pesan,
    this.kantor,
  });

  KantorResponse.fromJson(Map<String, dynamic> json) {
    pesan = json['message']?.toString();
    kantor =
        (json['company'] != null) ? Kantor.fromJson(json['company']) : null;
  }
  
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = pesan;
    if (kantor != null) {
      data['company'] = kantor!.toJson();
    }
    return data;
  }
}
