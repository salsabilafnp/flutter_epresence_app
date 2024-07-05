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

List<User> users = [
  User(
    userId: 'stf01',
    nama: 'John Doe',
    email: 'john.doe@example.com',
    password: 'password123',
    phoneNumber: '081234567890',
    role: 'karyawan',
    employeeType: 'full time',
    department: 'IT',
    position: 'Software Engineer',
    faceEmbedding: 'embedding123',
    imageUrl: 'avatar.png',
  ),
  User(
    userId: 'adm01',
    nama: 'Jane Smith',
    email: 'jane.smith@example.com',
    password: 'password456',
    phoneNumber: '082345678901',
    role: 'admin',
    employeeType: 'full time',
    department: 'HR',
    position: 'HR Specialist',
    faceEmbedding: 'embedding456',
    imageUrl: 'avatar2.png',
  ),
];
