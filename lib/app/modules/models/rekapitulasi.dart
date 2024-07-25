class RekapitulasiKaryawan {
  int? totalPresensi;
  int? totalCuti;
  int? totalIzin;
  int? totalSakit;
  int? totalWFH;

  RekapitulasiKaryawan({
    this.totalPresensi,
    this.totalCuti,
    this.totalIzin,
    this.totalSakit,
    this.totalWFH,
  });
  RekapitulasiKaryawan.fromJson(Map<String, dynamic> json) {
    totalPresensi = json['totalAttendance']?.toInt();
    totalCuti = json['totalLeave']?.toInt();
    totalIzin = json['totalAnnualLeave']?.toInt();
    totalSakit = json['totalSickLeave']?.toInt();
    totalWFH = json['totalWFH']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalAttendance'] = totalPresensi;
    data['totalLeave'] = totalCuti;
    data['totalAnnualLeave'] = totalIzin;
    data['totalSickLeave'] = totalSakit;
    data['totalWFH'] = totalWFH;
    return data;
  }
}

class RekapitulasiAdmin {
  int? totalPresensi;
  int? totalCuti;
  int? totalCutiDiajukan;
  int? totalCutiDisetujui;
  int? totalCutiDitolak;

  RekapitulasiAdmin({
    this.totalPresensi,
    this.totalCuti,
    this.totalCutiDiajukan,
    this.totalCutiDisetujui,
    this.totalCutiDitolak,
  });
  RekapitulasiAdmin.fromJson(Map<String, dynamic> json) {
    totalPresensi = json['totalAttendance']?.toInt();
    totalCuti = json['totalPermissions']?.toInt();
    totalCutiDiajukan = json['totalPending']?.toInt();
    totalCutiDisetujui = json['totalApproved']?.toInt();
    totalCutiDitolak = json['totalRejected']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalAttendance'] = totalPresensi;
    data['totalPermissions'] = totalCuti;
    data['totalPending'] = totalCutiDiajukan;
    data['totalApproved'] = totalCutiDisetujui;
    data['totalRejected'] = totalCutiDitolak;
    return data;
  }
}
