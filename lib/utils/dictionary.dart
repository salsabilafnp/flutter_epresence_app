class Dictionary {
  static const kembali = "Kembali";
  static const batal = "Batal";

  // Menu
  static const beranda = "Beranda";
  static const notifikasi = "Notifikasi";
  static const riwayatPresensi = "Riwayat Presensi";
  static const presensi = 'Presensi';
  static const detailPresensi = 'Detail Presensi';
  static const verifikasiWajah = 'Verifikasi Identitas';
  static const catatPresensiMasuk = "Presensi Masuk";
  static const catatPresensiKeluar = "Presensi Keluar";
  static const lokasiPresensiMasuk = "Lokasi Presensi Masuk";
  static const lokasiPresensKeluar = "Lokasi Presensi Keluar";
  static const riwayatAjuanCuti = "Riwayat Ajuan Cuti";
  static const pengajuanCuti = "Pengajuan Cuti";
  static const detailAjuanCuti = "Detail Ajuan Cuti";
  static const profil = "Profil";

  // Optional Menu
  static const lihatLokasi = "Lihat Lokasi";
  static const lihatDetail = "Lihat Detail";
  static const konfirmasi = "Konfirmasi";
  static const filter = "Filter";
  static const terapkanFilter = "Terapkan";
  static const filterTanggal = "Berdasarkan Tanggal";
  static const tanggalMulai = "Dari Tanggal";
  static const tanggalAkhir = "Sampai Tanggal";
  static const filterJenisAjuan = "Berdasarkan Jenis Pengajuan";
  static const filterStatusAjuan = "Berdasarkan Status Ajuan";

  // Presensi
  static const presensiHariIni = 'Presensi Hari ini';
  static const presensiMasuk = 'Presensi Masuk';
  static const presensiPulang = 'Presensi Pulang';
  static const hadirMasuk = 'Masuk';
  static const hadirPulang = 'Pulang';
  static const lokasiMasuk = "Lokasi Masuk";
  static const lokasiPulang = "Lokasi Pulang";

  // Cuti
  static const jenisPengajuan = 'Jenis Pengajuan';
  static const tanggalCuti = 'Tanggal Awal Ajuan';
  static const durasi = 'Durasi';
  static const alasan = 'Alasan';
  static const buktiFile = 'Bukti Pengajuan';
  static const statusAjuan = 'Status Ajuan';
  static const waktuPengajuan = 'Diajukan Pada';
  static const ajukan = 'Ajukan';
  static const ubahAjuan = 'Simpan Perubahan';

  // jenis ajuan cuti
  static const sakit = 'Sakit';
  static const cuti = 'Cuti';
  static const wfh = 'WFH';
  static String mapTipe(String tipe) {
    switch (tipe.toLowerCase()) {
      case 'sick':
        return sakit;
      case 'annual':
        return cuti;
      case 'wfh':
        return wfh;
      default:
        return tipe;
    }
  }

  // status
  static const diajukan = 'Diajukan';
  static const disetujui = 'Disetujui';
  static const ditolak = 'Ditolak';
  static String mapStatus(String status) {
    switch (status.toLowerCase()) {
      case 'rejected':
        return ditolak;
      case 'pending':
        return diajukan;
      case 'approved':
        return disetujui;
      default:
        return status;
    }
  }

  // Rekapitulasi
  static const hadir = 'Hadir';
  static const rekapPresensi = 'Rekapitulasi Presensi';
  static const absen = 'Absen';
  static const rekapCuti = 'Rekapitulasi Ajuan Cuti';

  // Auth
  static const logIn = 'Masuk';
  static const logOut = 'Keluar';
  static const email = 'Email';
  static const password = 'Kata Sandi';
  static const gantiAkses = 'Ganti Hak Akses';

  // Profil
  static const nama = 'Nama';
  static const departemen = 'Departemen';
  static const posisi = 'Posisi';
  static const noHP = 'No. Handphone';

  // Employee Type
  static const fullTime = 'Full Time';
  static const intern = 'Internship';

  // Role
  static const admin = 'Admin';
  static const staff = 'Karyawan';

  // Message
  static const defaultError = 'Terjadi Kesalahan';
  static const defaultSuccess = 'Berhasil';

  // MSG Auth
  static const suksesLogin = 'Login berhasil';
  static const gagalLogin = 'Email atau kata sandi salah';

  // MSG Presensi
  static const gagalPresensiMasuk = 'Presensi masuk gagal tercatat';
  static const gagalPresensiPulang = 'Presensi pulang gagal tercatat';
  static const suksesPresensiMasuk = 'Presensi masuk berhasil tercatat';
  static const suksesPresensiPulang = 'Presensi pulang berhasil tercatat';

  // MSG Cuti
  static const gagalAjuanCuti = 'Ajuan cuti gagal terkirim';
  static const suksesAjuanCuti = 'Ajuan cuti berhasil terkirim';
  static const gagalUbahCuti = 'Perubahan ajuan cuti gagal disimpan';
  static const suksesUbahCuti = 'Perubahan ajuan cuti berhasil disimpan';
}
