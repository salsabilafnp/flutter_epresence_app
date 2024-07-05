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
    userId: 'stf01',
    tanggalMulai: '2024-07-08',
    durasi: 2,
    jenisCuti: 'wfh',
    alasan: 'Mengurus perpindahan rumah',
    fileUrl: 'bukti_foto.png',
    status: 'Diajukan',
  ),
  Cuti(
    id: 3,
    userId: 'adm01',
    tanggalMulai: '2024-06-27',
    durasi: 2,
    jenisCuti: 'sakit',
    alasan: 'Sedang dalam perawatan medis',
    fileUrl: 'foto_rs.png',
    status: 'Disetujui',
  ),
  Cuti(
    id: 4,
    userId: 'adm01',
    tanggalMulai: '2024-07-08',
    durasi: 2,
    jenisCuti: 'wfh',
    alasan: 'Mengurus perpindahan rumah',
    fileUrl: 'bukti_foto.png',
    status: 'Diajukan',
  ),
];
