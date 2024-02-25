import 'dart:convert';

Authenticate authenticateFromJson(String str) => Authenticate.fromJson(json.decode(str));

String authenticateToJson(Authenticate data) => json.encode(data.toJson());

class Authenticate {
  String accessToken;
  String refreshToken;
  bool? isChosenFavorite;
  String role;

  Authenticate({
    required this.accessToken,
    required this.refreshToken,
    this.isChosenFavorite,
    this.role = 'VOLUNTEER',
  });

  factory Authenticate.fromJson(Map<String, dynamic> json) => Authenticate(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    isChosenFavorite: json["isChosenFavorite"],
    role: json["role"] ?? 'VOLUNTEER'
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "isChosenFavorite": isChosenFavorite,
    "role": role,
  };
}

enum ERole {
  volunteer,
  sponsor,
  organization
}
