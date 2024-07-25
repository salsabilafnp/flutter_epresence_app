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

class UserNetwork {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? twoFactorSecret;
  String? twoFactorRecoveryCodes;
  String? twoFactorConfirmedAt;
  String? phoneNumber;
  String? role;
  String? employeeType;
  String? department;
  String? position;
  String? faceEmbedding;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  UserNetwork({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.phoneNumber,
    this.role,
    this.employeeType,
    this.department,
    this.position,
    this.faceEmbedding,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  UserNetwork.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    email = json['email']?.toString();
    emailVerifiedAt = json['email_verified_at']?.toString();
    twoFactorSecret = json['two_factor_secret']?.toString();
    twoFactorRecoveryCodes = json['two_factor_recovery_codes']?.toString();
    twoFactorConfirmedAt = json['two_factor_confirmed_at']?.toString();
    phoneNumber = json['phone_number']?.toString();
    role = json['role']?.toString();
    employeeType = json['employee_type']?.toString();
    department = json['department']?.toString();
    position = json['position']?.toString();
    faceEmbedding = json['face_embedding']?.toString();
    imageUrl = json['image_url']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_secret'] = twoFactorSecret;
    data['two_factor_recovery_codes'] = twoFactorRecoveryCodes;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['phone_number'] = phoneNumber;
    data['role'] = role;
    data['employee_type'] = employeeType;
    data['department'] = department;
    data['position'] = position;
    data['face_embedding'] = faceEmbedding;
    data['image_url'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
