import 'package:flutter_epresence_app/app/modules/models/user.dart';

class Presensi {
  int? id;
  int? userId;
  String? date;
  String? checkInTime;
  String? checkOutTime;
  String? latlonIn;
  String? latlonOut;
  String? createdAt;
  String? updatedAt;
  User? user;

  Presensi({
    this.id,
    this.userId,
    this.date,
    this.checkInTime,
    this.checkOutTime,
    this.latlonIn,
    this.latlonOut,
    this.createdAt,
    this.updatedAt,
    this.user,
  });
  Presensi.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    userId = json['user_id']?.toInt();
    date = json['date']?.toString();
    checkInTime = json['checkIn_time']?.toString();
    checkOutTime = json['checkOut_time']?.toString();
    latlonIn = json['latlon_in']?.toString();
    latlonOut = json['latlon_out']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['date'] = date;
    data['checkIn_time'] = checkInTime;
    data['checkOut_time'] = checkOutTime;
    data['latlon_in'] = latlonIn;
    data['latlon_out'] = latlonOut;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
