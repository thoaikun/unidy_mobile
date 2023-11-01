import 'dart:convert';

Authenticate authenticateFromJson(String str) => Authenticate.fromJson(json.decode(str));

String authenticateToJson(Authenticate data) => json.encode(data.toJson());

class Authenticate {
  Headers headers;
  Body? body;
  int statusCodeValue;
  String statusCode;

  Authenticate({
    required this.headers,
    this.body,
    required this.statusCodeValue,
    required this.statusCode,
  });

  factory Authenticate.fromJson(Map<String, dynamic> json) => Authenticate(
    headers: Headers.fromJson(json["headers"]),
    body: json["body"] is String ? null : Body.fromJson(json["body"]),
    statusCodeValue: json["statusCodeValue"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "headers": headers.toJson(),
    "body": body?.toJson(),
    "statusCodeValue": statusCodeValue,
    "statusCode": statusCode,
  };
}

class Body {
  String accessToken;
  String refreshToken;

  Body({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
  );

  Map<String, dynamic> toJson() => {
  };
}