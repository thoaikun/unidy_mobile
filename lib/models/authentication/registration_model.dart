
import 'dart:convert';

Registration registrationFromJson(String str) => Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Headers headers;
  String body;
  String statusCode;
  int statusCodeValue;

  Registration({
    required this.headers,
    required this.body,
    required this.statusCode,
    required this.statusCodeValue,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    headers: Headers.fromJson(json["headers"]),
    body: json["body"],
    statusCode: json["statusCode"],
    statusCodeValue: json["statusCodeValue"],
  );

  Map<String, dynamic> toJson() => {
    "headers": headers.toJson(),
    "body": body,
    "statusCode": statusCode,
    "statusCodeValue": statusCodeValue,
  };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
  );

  Map<String, dynamic> toJson() => {
  };
}
