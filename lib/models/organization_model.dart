import 'dart:convert';

Organization organizationFromJson(String str) => Organization.fromJson(json.decode(str));

String organizationToJson(Organization data) => json.encode(data.toJson());

class Organization {
  int organizationId;
  String organizationName;
  String address;
  String phone;
  String email;
  String status;
  String country;
  int userId;
  String firebaseTopic;

  Organization({
    required this.organizationId,
    required this.organizationName,
    required this.address,
    required this.phone,
    required this.email,
    required this.status,
    required this.country,
    required this.userId,
    required this.firebaseTopic,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    organizationId: json["organizationId"],
    organizationName: json["organizationName"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    status: json["status"],
    country: json["country"],
    userId: json["userId"],
    firebaseTopic: json["firebaseTopic"],
  );

  Map<String, dynamic> toJson() => {
    "organizationId": organizationId,
    "organizationName": organizationName,
    "address": address,
    "phone": phone,
    "email": email,
    "status": status,
    "country": country,
    "userId": userId,
    "firebaseTopic": firebaseTopic,
  };
}