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

  @override
  String toString() {
    // TODO: implement toString
    return {
      'value': value,
      'code': code
    }.toString();
  }
}

enum ExceptionErrorCode {
  invalid,
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
  invalidFriendRequest,
}