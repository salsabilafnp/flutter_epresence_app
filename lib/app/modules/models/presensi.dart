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

List<Presensi> presensiData = [
  Presensi(
    id: 1,
    userId: 'stf01',
    tanggal: '2024-07-01',
    waktuMasuk: '08:00',
    waktuPulang: '17:00',
    lokasiMasuk: '114.56789012\n-8.1234567',
    lokasiPulang: '114.56789012\n-8.1234567',
  ),
  Presensi(
    id: 2,
    userId: 'stf01',
    tanggal: '2024-07-02',
    waktuMasuk: '08:15',
    waktuPulang: '17:05',
    lokasiMasuk: '114.56789012\n-8.1234567',
    lokasiPulang: '114.56789012\n-8.1234567',
  ),
  Presensi(
    id: 3,
    userId: 'adm01',
    tanggal: '2024-07-03',
    waktuMasuk: '07:50',
    waktuPulang: '17:10',
    lokasiMasuk: '114.56789012\n-8.1234567',
    lokasiPulang: '114.56789012\n-8.1234567',
  ),
  Presensi(
    id: 4,
    userId: 'adm01',
    tanggal: '2024-07-04',
    waktuMasuk: '08:01',
    waktuPulang: '16:59',
    lokasiMasuk: '114.56789012\n-8.1234567',
    lokasiPulang: '114.56789012\n-8.1234567',
  ),
];
