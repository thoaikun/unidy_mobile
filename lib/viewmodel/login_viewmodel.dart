import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/local_data_model.dart';
import 'package:unidy_mobile/services/authentication_service.dart';
import 'package:unidy_mobile/services/user_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';

class LoginViewModel extends ChangeNotifier {
  void Function(ERole role) navigateToHomeScreen;
  void Function() navigateToVolunteerCategoriesSelectionScreen;
  void Function([String? title, String? content]) showErrorDialog;

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

  LoginViewModel({
    required this.navigateToHomeScreen,
    required this.navigateToVolunteerCategoriesSelectionScreen,
    required this.showErrorDialog
  }) {
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
    String? data = appPreferences.getString('localData');

    if (data == null) {
      LocalData localData = LocalData(authenticationResponse.accessToken, authenticationResponse.refreshToken, false, authenticationResponse.isChosenFavorite ?? true, authenticationResponse.role);
      await appPreferences.setString('localData', jsonEncode(localData.toJson()));
    }
    else {
      LocalData localData = LocalData.fromJson(jsonDecode(data));
      localData.accessToken = authenticationResponse.accessToken;
      localData.refreshToken = authenticationResponse.refreshToken;
      localData.accountMode = LocalData.accountModeFromString(authenticationResponse.role);
      localData.isFirstTimeOpenApp = false;
      localData.isChosenFavorite = authenticationResponse.isChosenFavorite ?? true;
      await appPreferences.setString('localData', jsonEncode(localData.toJson()));
    }
    httpClient.addHeader('Authorization', 'Bearer ${authenticationResponse.accessToken}');
    _setLoadingLogin(false);
    if (authenticationResponse.role == 'VOLUNTEER') {
      if (authenticationResponse.isChosenFavorite == true) {
        navigateToHomeScreen(ERole.volunteer);
      }
      else {
        navigateToVolunteerCategoriesSelectionScreen();
      }
    }
    else if (authenticationResponse.role == 'ORGANIZATION') {
      navigateToHomeScreen(ERole.organization);
    }
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
      showErrorDialog();
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}