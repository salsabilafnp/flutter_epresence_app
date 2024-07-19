import 'package:intl/intl.dart';

class PermissionsRequest {
  String? permitType;
  String? leaveDate;
  int? duration;
  String? reason;
  String? fileUrl;
  String? status;

  PermissionsRequest({
    this.permitType,
    this.leaveDate,
    this.duration,
    this.reason,
    this.fileUrl,
    this.status,
  });

  static String checkPermitType(String type) {
    switch (type.toLowerCase()) {
      case 'sakit':
        return 'sick';
      case 'cuti':
        return 'annual';
      case 'wfh':
        return 'wfh';
      default:
        return type;
    }
  }

  static String checkStatus(String status) {
    switch (status.toLowerCase()) {
      case 'ditolak':
        return 'rejected';
      case 'diajukan':
        return 'pending';
      case 'disetujui':
        return 'approved';
      default:
        return status;
    }
  }

  Map<String, dynamic> toJson() {
    DateTime parsedDate = DateFormat('EEEE, d MMMM y').parse(leaveDate!);
    String formattedDate = DateFormat('yyyy-MM-d').format(parsedDate);

    return {
      'permit_type': checkPermitType(permitType!),
      'leave_date': formattedDate,
      'duration': duration,
      'reason': reason,
      'file_url': fileUrl,
      'status': checkStatus(status!),
    };
  }
}
