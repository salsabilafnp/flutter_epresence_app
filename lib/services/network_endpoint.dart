class NetworkEndpoint {
  static const baseUrl = 'http://192.168.100.106:8000/api';

  // auth
  static const login = '$baseUrl/login';
  static const profile = '$baseUrl/user';
  static const logout = '$baseUrl/logout';
  static const updateProfile = '$baseUrl/update-profile';

  // presensi
  static const presensi = '$baseUrl/attendance';
  static const presensiHariIni = '$baseUrl/attendance/today';
  static const presensiCheckIn = '$baseUrl/attendance/check-in';
  static const presensiCheckOut = '$baseUrl/attendance/check-out';
  static const presensiSemuaRiwayat = '$baseUrl/attendance/all-history';
  static const presensiRiwayat = '$baseUrl/attendance/history';

  // cuti
  static const cuti = '$baseUrl/permission';
  static const cutiSemuaRiwayat = '$baseUrl/permission/all-history';
  static const cutiKonfirmasi = '$baseUrl/permission/history/confirm';
}
