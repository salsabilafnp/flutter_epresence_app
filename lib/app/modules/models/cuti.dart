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
