class User {
  final String? userId;
  final String nama;
  final String email;
  final String? password;
  final String phoneNumber;
  final String role;
  final String employeeType;
  final String department;
  final String position;
  final String? faceEmbedding;
  final String imageUrl;

  User({
    this.userId,
    required this.nama,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.role,
    required this.employeeType,
    required this.department,
    required this.position,
    this.faceEmbedding,
    required this.imageUrl,
  });
}
