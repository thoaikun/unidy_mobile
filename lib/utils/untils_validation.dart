import 'dart:async';

class ValidationException implements Exception {
  String value;
  String get message => value;

  ValidationException({ required this.value });
}

abstract class Validation extends StreamTransformerBase<String, bool> {
  bool _validate(String value) {
    if (value.isEmpty) {
      throw ValidationException(value: 'Không được bỏ trống');
    }
    return true;
  }
  @override
  Stream<bool> bind(Stream<String> stream) {
    return stream.map((email) => _validate(email));
  }
}

class EmailValidation extends StreamTransformerBase<String, bool> implements Validation  {
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

class PasswordValidation extends StreamTransformerBase<String, bool> implements Validation {
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

class PhoneValidation extends StreamTransformerBase<String, bool> implements Validation {
  @override
  bool _validate(String phone) {
    RegExp phonePattern = RegExp(r'^0\d{9}$');
    if (!phonePattern.hasMatch(phone)) {
      throw ValidationException(value: 'Số điện thoại không hợp lệ');
    }
    return true;
  }

  @override
  Stream<bool> bind(Stream<String> stream) {
    return stream.map((event) => _validate(event));
  }
}

