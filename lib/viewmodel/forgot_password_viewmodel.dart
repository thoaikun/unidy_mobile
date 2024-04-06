import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/services/authentication_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/services/user_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';
import 'package:unidy_mobile/utils/validation_util.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  static const int MAX_STEP = 3;
  final AuthenticationService authenticationService = GetIt.instance<AuthenticationService>();
  final UserService userService = GetIt.instance<UserService>();
  void Function(String title, String message) showForgotPasswordDialog;

  int _currentStep = 0;
  bool showPassword = false;
  String otpValue = '';
  String email = '';
  String newPassword = '';
  String resetPasswordToken = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();

  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _otpSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _newPasswordSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _confirmNewPasswordSubject = BehaviorSubject<String>();

  String? emailError;
  String? otpError;
  String? passwordError;
  String? confirmPasswordError;

  bool loading = false;

  int get currentStep => _currentStep;
  TextEditingController get emailController => _emailController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get confirmNewPasswordController => _confirmNewPasswordController;

  ForgotPasswordViewModel({ required this.showForgotPasswordDialog }) {
    emailController.addListener(() { _setEmailError(null); });
    newPasswordController.addListener(() { _setPasswordError(null); });
    confirmNewPasswordController.addListener(() { _setConfirmPasswordError(null); });

    _setupEmailStream();
    _setupOtpStream();
    _setupNewPasswordStream();
  }

  void _setCurrentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }

  void setOtpValue(String value) {
    otpValue = value;
    print(otpValue);
  }

  void _setEmailError(String? value) {
    emailError = value;
    notifyListeners();
  }

  void _setOtpError(String? value) {
    otpError = value;
    notifyListeners();
  }

  void _setPasswordError(String? value) {
    passwordError = value;
    notifyListeners();
  }

  void _setConfirmPasswordError(String? value) {
    confirmPasswordError = value;
    notifyListeners();
  }

  void _setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void toggleShowPassword(bool? value) {
    showPassword = value ?? false;
    notifyListeners();
  }

  void onClickConfirmEmail() {
    Sink<String> emailSink = _emailSubject.sink;
    emailSink.add(_emailController.text);
  }

  void onClickConfirmOtp() {
    Sink<String> otpSink = _otpSubject.sink;
    otpSink.add(otpValue);
  }

  void onClickResendOtp() {
    _setLoading(true);
    authenticationService.confirmEmail({
      'email': email
    })
      .then((_) {
        _setLoading(false);
      })
      .catchError(_handleForgotPasswordError);
  }

  void onClickConfirmNewPassword() {
    _newPasswordSubject.add(_newPasswordController.text);
    _confirmNewPasswordSubject.add(_confirmNewPasswordController.text);
  }

  void _setupEmailStream() {
    Stream<String> emailStream = _emailSubject.stream;

    emailStream.transform(EmailValidationTransformer())
      .debounceTime(const Duration(milliseconds: 500))
      .listen((email) {
        if (_currentStep != 0) return;

        this.email = email;
        _setLoading(true);
        authenticationService.confirmEmail({
          'email': email
        })
          .then((_) {
            _setLoading(false);
            _setCurrentStep(_currentStep + 1);
          })
          .catchError(_handleForgotPasswordError);
      })
      .onError(_handleForgotPasswordError);
  }

  void _setupOtpStream() {
    Stream<String> otpStream = _otpSubject.stream;

    otpStream.debounceTime(const Duration(milliseconds: 500))
      .listen((otp) {
        if (_currentStep != 1) return;

        _setLoading(true);
        authenticationService.confirmOtp({
          'otp': otp,
          'email': email
        })
          .then((authenticate) {
            resetPasswordToken = authenticate.accessToken;
            _setCurrentStep(_currentStep + 1);
            _setLoading(false);
          })
          .catchError(_handleForgotPasswordError);
      });
  }

  void _setupNewPasswordStream() {
    Stream<String> newPasswordStream = _newPasswordSubject.stream;
    Stream<String> confirmPasswordStream = _confirmNewPasswordSubject.stream;

    confirmPasswordStream.withLatestFrom(
      newPasswordStream.transform(PasswordValidationTransformer()),
      (confirmPassword, newPassword) => [newPassword, confirmPassword]
    )
      .transform(ValidationSimilarPasswordTransformer())
      .debounceTime(const Duration(milliseconds: 500))
      .listen((newPassword) {
        if (_currentStep != 2) return;

        _setLoading(true);
        userService.resetPassword({
          'newPassword' : newPassword,
          'confirmationPassword' : newPassword
        }, resetPasswordToken)
          .then((_) {
            _setLoading(false);
            showForgotPasswordDialog('Thành công', 'Mật khẩu đã được thay đổi');
          })
          .catchError(_handleForgotPasswordError);
      })
      .onError(_handleForgotPasswordError);
  }

  void _handleForgotPasswordError(Object error) {
    _setLoading(false);
    if (error is ValidationException) {
      switch (error.code) {
        case ExceptionErrorCode.invalidEmail:
          _setEmailError(error.message);
          break;
        case ExceptionErrorCode.invalidPassword:
          _setPasswordError(error.message);
          break;
        case ExceptionErrorCode.invalidConfirmPassword:
          _setConfirmPasswordError(error.message);
          break;
        default:
          break;
      }
    }
    else if (error is ResponseException) {
      switch (error.code) {
        case ExceptionErrorCode.invalidEmail:
          _setEmailError(error.message);
          break;
        case ExceptionErrorCode.invalidOtp:
          showForgotPasswordDialog('Thất bại', 'Mã OTP không đúng, vui lòng thử lại.');
          break;
        default:
          break;
      }
    }
    else {
      showForgotPasswordDialog('Thất bại', 'Có lỗi xảy ra, vui lòng thử lại sau.');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
  }
}