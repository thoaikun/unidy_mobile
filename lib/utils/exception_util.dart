class ValidationException implements Exception {
  String value;
  String get message => value;

  ValidationException({ required this.value });
}

class ResponseException implements Exception {
  String value;
  ExceptionErrorCode code;

  String get message => value;
  ExceptionErrorCode get errorCode => code;

  ResponseException({ required this.value, required this.code });
}

enum ExceptionErrorCode {
  invalidEmail,
  invalidPassword,
  invalidOtp,
  invalidRegistration,
  invalidLogin
}