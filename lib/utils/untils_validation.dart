import 'dart:async';

class ValidationException implements Exception {
  String value;
  String get message => value;

  ValidationException({ required this.value });
}

abstract class Validation<S> {
  bool _validate(S value);
}

class EmailValidation extends StreamTransformerBase<String, bool> implements Validation<String>  {
  @override
  bool _validate(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(email)) {
      throw ValidationException(value: 'Email không hợp lệ');
    }
    return true;
  }

  @override
  Stream<bool> bind(Stream<String> stream) {
    return stream.map((email) => _validate(email));
  }
}

class PasswordValidation extends StreamTransformerBase<String, bool> implements Validation<String> {
  @override
  bool _validate(String password) {
    if (password.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[a-z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)
    ) {
      throw ValidationException(value: 'Mật khẩu không hợp lệ');
    }
    return true;
  }

  @override
  Stream<bool> bind(Stream<String> stream) {
    return stream.map((password) => _validate(password));
  }
}