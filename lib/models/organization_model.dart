import 'dart:convert';

Organization organizationFromJson(String str) => Organization.fromJson(json.decode(str));

String organizationToJson(Organization data) => json.encode(data.toJson());

class Organization {
  int userId;
  String organizationName;
  String address;
  String phone;
  String email;
  String country;
  String firebaseTopic;
  String? image;
  bool isFollow;

  Organization({
    required this.userId,
    required this.organizationName,
    required this.address,
    required this.phone,
    required this.email,
    required this.country,
    required this.firebaseTopic,
    this.image,
    this.isFollow = false
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    userId: json["userId"],
    organizationName: json["organizationName"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    country: json["country"],
    firebaseTopic: json["firebaseTopic"],
    image: json["image"],
    isFollow: json["isFollow"]
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "organizationName": organizationName,
    "address": address,
    "phone": phone,
    "email": email,
    "country": country,
    "firebaseTopic": firebaseTopic,
    "image": image,
    "isFollow": isFollow
  };
}