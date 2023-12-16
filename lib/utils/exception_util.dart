class ValidationException implements Exception {
  String value;
  ExceptionErrorCode code;

  String get message => value;
  ExceptionErrorCode get errorCode => code;

  ValidationException({ required this.value, required this.code  });
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
  invalidConfirmPassword,
  invalidInput,
  invalidPhone,
  invalidJob,
  invalidWorkplace,
  invalidName,
  invalidDob,
  invalidOtp,
  invalidRegistration,
  invalidLogin,
  invalidResetPassword,
  invalidToken,
  invalidImageExtension,
  invalidUserId,
}