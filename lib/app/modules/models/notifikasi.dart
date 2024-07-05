class Notifikasi {
  final String title;
  final String message;
  final DateTime date;
  final bool isReminder;
  final bool isForStaff;

  Notifikasi({
    required this.title,
    required this.message,
    required this.date,
    this.isReminder = false,
    this.isForStaff = true,
  });
}

List<Notifikasi> notifications = [
  Notifikasi(
    title: 'Pengingat Presensi',
    message: 'Jangan lupa untuk presensi masuk!',
    date: DateTime.now().subtract(Duration(hours: 1)),
    isReminder: true,
  ),
  Notifikasi(
    title: 'Pengajuan Cuti Ditindaklanjuti',
    message: 'Pengajuan cuti Anda telah disetujui.',
    date: DateTime.now().subtract(Duration(days: 1)),
  ),
  Notifikasi(
    title: 'Ajuan Cuti Baru',
    message:
        'John Doe mengajukan cuti untuk 15 Juli 2024. Mohon tindaklanuti ajuan cuti ini.',
    date: DateTime.now().subtract(Duration(days: 1)),
    isForStaff: false,
  ),
];
