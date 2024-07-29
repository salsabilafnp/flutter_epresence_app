import 'package:flutter_epresence_app/app/modules/models/user.dart';

class Cuti {
  int? id;
  int? userId;
  String? permitType;
  String? leaveDate;
  int? duration;
  String? reason;
  String? fileUrl;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  Cuti({
    this.id,
    this.userId,
    this.permitType,
    this.leaveDate,
    this.duration,
    this.reason,
    this.fileUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });
  Cuti.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    userId = json['user_id']?.toInt();
    permitType = json['permit_type']?.toString();
    leaveDate = json['leave_date']?.toString();
    duration = json['duration']?.toInt();
    reason = json['reason']?.toString();
    fileUrl = json['file_url']?.toString();
    status = json['status']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['permit_type'] = permitType;
    data['leave_date'] = leaveDate;
    data['duration'] = duration;
    data['reason'] = reason;
    data['file_url'] = fileUrl;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
