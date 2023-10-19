import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/utils/untils_validation.dart';

class LoginViewModel extends ChangeNotifier {
  final Duration debounceTime = const Duration(milliseconds: 500);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  String? emailError;
  String? passwordError;

  LoginViewModel() {
    _emailController.addListener(() => _setEmailError(null));
    _passwordController.addListener(() => _setPasswordError(null));

    Stream<String> emailStream = _emailSubject.stream;
    Stream<String> passwordStream = _passwordSubject.stream;

    ZipStream.zip2(
      emailStream.transform(EmailValidation()),
      passwordStream.transform(PasswordValidation()),
      (a, b) => a && b
    ).doOnError((error, stackTrace) {
      if (error is ValidationException) {
        switch (error.message) {
          case 'Mật khẩu không hợp lệ':
            _setEmailError(error.message);
            break;
          case 'Email không hợp lệ':
            _setPasswordError(error.message);
            break;
        }
      }
    }).listen((event) {
      print('ok');
    });
  }
  
  void _setEmailError(String? error) {
    emailError = error;
    notifyListeners();
  }

  void _setPasswordError(String? error) {
    passwordError = error;
    notifyListeners();
  }

  void handleOnClick() {
    Sink<String> emailSink = _emailSubject.sink;
    Sink<String> passwordSink = _passwordSubject.sink;

    emailSink.add(_emailController.text);
    passwordSink.add(_passwordController.text);
  }
}