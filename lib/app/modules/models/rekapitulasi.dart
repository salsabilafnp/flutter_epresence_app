class RekapitulasiKaryawan {
  int? totalPresensiKaryawan;
  int? totalCutiKaryawan;
  int? totalIzin;
  int? totalSakit;
  int? totalWFH;

  RekapitulasiKaryawan({
    this.totalPresensiKaryawan,
    this.totalCutiKaryawan,
    this.totalIzin,
    this.totalSakit,
    this.totalWFH,
  });
  RekapitulasiKaryawan.fromJson(Map<String, dynamic> json) {
    totalPresensiKaryawan = json['totalAttendance']?.toInt();
    totalCutiKaryawan = json['totalLeave']?.toInt();
    totalIzin = json['totalAnnualLeave']?.toInt();
    totalSakit = json['totalSickLeave']?.toInt();
    totalWFH = json['totalWFH']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalAttendance'] = totalPresensiKaryawan;
    data['totalLeave'] = totalCutiKaryawan;
    data['totalAnnualLeave'] = totalIzin;
    data['totalSickLeave'] = totalSakit;
    data['totalWFH'] = totalWFH;
    return data;
  }
}

class RekapitulasiAdmin {
  int? totalPresensiAdmin;
  int? totalCutiAdmin;
  int? totalCutiDiajukan;
  int? totalCutiDisetujui;
  int? totalCutiDitolak;

  RekapitulasiAdmin({
    this.totalPresensiAdmin,
    this.totalCutiAdmin,
    this.totalCutiDiajukan,
    this.totalCutiDisetujui,
    this.totalCutiDitolak,
  });
  RekapitulasiAdmin.fromJson(Map<String, dynamic> json) {
    totalPresensiAdmin = json['totalAttendance']?.toInt();
    totalCutiAdmin = json['totalPermissions']?.toInt();
    totalCutiDiajukan = json['totalPending']?.toInt();
    totalCutiDisetujui = json['totalApproved']?.toInt();
    totalCutiDitolak = json['totalRejected']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalAttendance'] = totalPresensiAdmin;
    data['totalPermissions'] = totalCutiAdmin;
    data['totalPending'] = totalCutiDiajukan;
    data['totalApproved'] = totalCutiDisetujui;
    data['totalRejected'] = totalCutiDitolak;
    return data;
  }
}
