class NetworkEndpoint {
  static const baseUrl = 'http://192.168.100.106:8000/api';

  // auth
  static const login = '$baseUrl/login';
  static const profile = '$baseUrl/user';
  static const logout = '$baseUrl/logout';
  static const updateProfile = '$baseUrl/update-profile';

  // presensi
  static const presensi = '$baseUrl/presensi';
  static const presensiDetail = '$baseUrl/presensi/detail';
  static const presensiCheckIn = '$baseUrl/presensi/check-in';
  static const presensiCheckOut = '$baseUrl/presensi/check-out';
  static const presensiHistory = '$baseUrl/presensi/history';
  static const presensiHistoryDetail = '$baseUrl/presensi/history/detail';

  // cuti
  static const cuti = '$baseUrl/cuti';
  static const cutiDetail = '$baseUrl/cuti/detail';
  static const cutiRequest = '$baseUrl/cuti/request';
  static const cutiHistory = '$baseUrl/cuti/history';
  static const cutiHistoryDetail = '$baseUrl/cuti/history/detail';
  static const cutiHistoryApprove = '$baseUrl/cuti/history/approve';
  static const cutiHistoryReject = '$baseUrl/cuti/history/reject';
}
