class Cuti {
  final int id;
  final String? userId;
  final String jenisCuti;
  final String tanggalMulai;
  final int durasi;
  final String alasan;
  final String fileUrl;
  final String status;

  Cuti({
    required this.id,
    this.userId,
    required this.tanggalMulai,
    required this.durasi,
    required this.jenisCuti,
    required this.alasan,
    required this.fileUrl,
    required this.status,
  });
}

List<Cuti> cutiData = [
  Cuti(
    id: 1,
    userId: 'stf01',
    tanggalMulai: '2024-06-27',
    durasi: 2,
    jenisCuti: 'sakit',
    alasan: 'Sedang dalam perawatan medis',
    fileUrl: 'foto_rs.png',
    status: 'Disetujui',
  ),
  Cuti(
    id: 2,
    userId: 'adm01',
    tanggalMulai: '2024-07-01',
    durasi: 2,
    jenisCuti: 'wfh',
    alasan: 'Acara keluarga',
    fileUrl: 'acara_keluarga.png',
    status: 'Ditolak',
  ),
  Cuti(
    id: 3,
    userId: 'stf01',
    tanggalMulai: '2024-07-08',
    durasi: 2,
    jenisCuti: 'wfh',
    alasan: 'Mengurus perpindahan rumah',
    fileUrl: 'bukti_foto.png',
    status: 'Diajukan',
  ),
  Cuti(
    id: 4,
    userId: 'adm01',
    tanggalMulai: '2024-07-05',
    durasi: 2,
    jenisCuti: 'cuti',
    alasan: 'Mengurus pasport',
    fileUrl: 'bukti_foto.png',
    status: 'Diajukan',
  ),
];

class CutiNetwork {
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

  CutiNetwork({
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
  });
  CutiNetwork.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
