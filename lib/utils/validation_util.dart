import 'exception_util.dart';

class Validation  {
  static String validateInput(String? value) {
    if (value == null) {
      throw ValidationException(value: 'Thông tin không hợp lệ');
    }
    else if (value.isEmpty) {
      throw ValidationException(value: 'Không được bỏ trống');
    }
    return value;
  }

  static String validateEmail(String? email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (email == null || !emailRegex.hasMatch(email)) {
      throw ValidationException(value: 'Email không hợp lệ');
    }
    return email;
  }

  static String validatePassword(String? password) {
    if (password == null ||
        password.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[a-z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)
    ) {
      throw ValidationException(value: 'Mật khẩu không hợp lệ');
    }
    return password;
  }

  static String validatePhone(String? phone) {
    RegExp phonePattern = RegExp(r'^0\d{9}$');
    if (phone == null || !phonePattern.hasMatch(phone)) {
      throw ValidationException(value: 'Số điện thoại không hợp lệ');
    }
    return phone;
  }
}

