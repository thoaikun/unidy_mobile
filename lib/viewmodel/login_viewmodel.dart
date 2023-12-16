import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/services/authentication_service.dart';
import 'package:unidy_mobile/services/user_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';

class LoginViewModel extends ChangeNotifier {
  final BuildContext context;
  final AuthenticationService authenticationService = GetIt.instance<AuthenticationService>();
  HttpClient httpClient = GetIt.instance<HttpClient>();
  final UserService userService = GetIt.instance<UserService>();
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
    await appPreferences.setString('accountMode', 'user');
    httpClient.addHeader('Authorization', 'Bearer ${authenticationResponse.accessToken}');
    _setLoadingLogin(false);
    Navigator.pushReplacementNamed(context, '/');
  }

  void _handleLoginError(Object error) {
    if (error is ValidationException) {
      _setEmailError(error.message);
      _setLoadingLogin(false);
    }
    else if (error is ResponseException) {
      _setEmailError(error.message);
      _setPasswordError(error.message);
      _setLoadingLogin(false);
    }
    else {
      _setLoadingLogin(false);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hệ thống đang bận'),
            content: const Text('Vui lòng đợi trong giây lát và thử lại'),
            actions: <Widget>[
              TextButton(
                child: const Text('Đồng ý'),
                onPressed: () => Navigator.of(context).pop()
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}