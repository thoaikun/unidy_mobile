import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int userId;
  String? fullName;
  String? address;
  String? phone;
  String? sex;
  DateTime? dayOfBirth;
  String? job;
  String? workLocation;
  String? role;
  String? image;
  bool? isFriend;
  bool? isRequested;
  bool? isRequesting;

  User({
    required this.userId,
    this.fullName,
    this.address,
    this.phone,
    this.sex,
    this.dayOfBirth,
    this.job,
    this.workLocation,
    this.role,
    this.image,
    this.isFriend,
    this.isRequested,
    this.isRequesting
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
    image: json['image'],
    isFriend: json['isFriend'],
    isRequested: json['isRequested'],
    isRequesting: json['isRequesting']
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "address": address,
    "phone": phone,
    "sex": sex,
    "dayOfBirth": dayOfBirth?.toIso8601String(),
    "job": job,
    "workLocation": workLocation,
    "role": role,
    "image": image,
    "isFriend": isFriend,
    "isRequested": isRequested,
    "isRequesting": isRequesting
  };
}
