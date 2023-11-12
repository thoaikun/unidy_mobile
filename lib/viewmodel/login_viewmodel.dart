import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/services/authentication_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/models/authentication/authenticate_model.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';

class LoginViewModel extends ChangeNotifier {
  final BuildContext context;
  final AuthenticationService authenticationService = GetIt.instance<AuthenticationService>();
  final AppPreferences appPreferences = GetIt.instance<AppPreferences>();
  final Duration debounceTime = const Duration(milliseconds: 500);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  String? emailError;
  String? passwordError;
  bool passwordVisible = false;
  bool loadingLogin = false;

  LoginViewModel({ required this.context }) {
    _emailController.addListener(() => _setEmailError(null));
    _passwordController.addListener(() => _setPasswordError(null));
    _setupLoginStream();
  }
  
  void _setEmailError(String? error) {
    emailError = error;
    notifyListeners();
  }

  void _setPasswordError(String? error) {
    passwordError = error;
    notifyListeners();
  }

  void _setLoadingLogin(bool value) {
    loadingLogin = value;
    notifyListeners();
  }

  void _setupLoginStream() {
    Stream<String> emailStream = _emailSubject.stream;
    Stream<String> passwordStream = _passwordSubject.stream;

    CombineLatestStream.combine2(
      emailStream.transform(EmailValidationTransformer()),
      passwordStream,
      (email, password) => {
        'email': email,
        'password': password
      }
    )
      .debounceTime(debounceTime)
      .listen((payload) {
        _setLoadingLogin(true);
        authenticationService.login(payload)
          .then(_handleLoginSuccess)
          .catchError(_handleLoginError);
        })
        .onError(_handleLoginError);
  }

  void onClickLogin() {
    Sink<String> emailSink = _emailSubject.sink;
    Sink<String> passwordSink = _passwordSubject.sink;

    emailSink.add(_emailController.text);
    passwordSink.add(_passwordController.text);
  }

  void togglePasswordVisible() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void _handleLoginSuccess(Authenticate authenticationResponse) async {
    await appPreferences.setString('accessToken', authenticationResponse.accessToken);
    await appPreferences.setString('refreshToken', authenticationResponse.refreshToken);
    _setLoadingLogin(false);
    Navigator.pushReplacementNamed(context, '/');
  }

  void _handleLoginError(Object error) {
    if (error is ValidationException) {
      _setEmailError(error.message);
      _setLoadingLogin(false);
    }
    if (error is ResponseException) {
      _setEmailError(error.message);
      _setPasswordError(error.message);
      _setLoadingLogin(false);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}