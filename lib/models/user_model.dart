import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int userId;
  String fullName;
  dynamic address;
  String phone;
  dynamic sex;
  DateTime dayOfBirth;
  String job;
  String workLocation;
  String role;

  User({
    required this.userId,
    required this.fullName,
    required this.address,
    required this.phone,
    required this.sex,
    required this.dayOfBirth,
    required this.job,
    required this.workLocation,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    fullName: json["fullName"],
    address: json["address"],
    phone: json["phone"],
    sex: json["sex"],
    dayOfBirth: DateTime.parse(json["dayOfBirth"]),
    job: json["job"],
    workLocation: json["workLocation"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "address": address,
    "phone": phone,
    "sex": sex,
    "dayOfBirth": dayOfBirth.toIso8601String(),
    "job": job,
    "workLocation": workLocation,
    "role": role,
  };
}
