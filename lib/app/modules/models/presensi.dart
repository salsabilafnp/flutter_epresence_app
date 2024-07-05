class Presensi {
  final int id;
  final String? userId;
  final String tanggal;
  final String waktuMasuk;
  final String waktuPulang;
  final String lokasiMasuk;
  final String lokasiPulang;

  Presensi({
    required this.id,
    this.userId,
    required this.tanggal,
    required this.waktuMasuk,
    required this.waktuPulang,
    required this.lokasiMasuk,
    required this.lokasiPulang,
  });
}
