import 'dart:convert';

Authenticate authenticateFromJson(String str) => Authenticate.fromJson(json.decode(str));

String authenticateToJson(Authenticate data) => json.encode(data.toJson());

class Authenticate {
  String accessToken;
  String refreshToken;

  Authenticate({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Authenticate.fromJson(Map<String, dynamic> json) => Authenticate(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}