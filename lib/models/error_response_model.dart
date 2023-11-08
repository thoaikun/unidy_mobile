import 'dart:convert';

ErrorResponse errorFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  String error;

  ErrorResponse({
    required this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
