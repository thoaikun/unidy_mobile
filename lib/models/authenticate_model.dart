import 'dart:convert';

Authenticate authenticateFromJson(String str) => Authenticate.fromJson(json.decode(str));

String authenticateToJson(Authenticate data) => json.encode(data.toJson());

class Authenticate {
  String accessToken;
  String refreshToken;
  bool? isChosenFavorite;

  Authenticate({
    required this.accessToken,
    required this.refreshToken,
    this.isChosenFavorite,
  });

  factory Authenticate.fromJson(Map<String, dynamic> json) => Authenticate(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"].toString(),
    isChosenFavorite: json["isChosenFavorite"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "isChosedFavorite": isChosenFavorite,
  };
}

enum ERole {
  volunteer,
  sponsor,
  organization
}
