import 'dart:convert';

class UserModel {
  final String? name;
  final String? username;
  final String email;
  final String? phone;
  final String password;

  UserModel({
    this.name,
    this.username,
    required this.email,
    this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  /// JSON string → UserModel
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  /// Map JSON
  Map<String, dynamic> toJson() => toMap();
}
