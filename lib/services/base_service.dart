import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/main.dart';
import 'package:unidy_mobile/models/local_data_model.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';

class Service {
  final AppPreferences _appPreferences = GetIt.instance<AppPreferences>();

  void catchForbidden() {
    _handleCleanCache()
      .then((_) {
        // Route<dynamic>? route = ModalRoute.of(navigatorKey.currentContext!);
        // if ((route?.settings.name ?? '') == '/login') {
        //   return;
        // }
        // navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const PopScope(canPop: false, child: LoginScreen())));
      });
  }

  Future<void> _handleCleanCache() async {
    String? data = _appPreferences.getString('localData');
    if (data != null) {
      LocalData localData = LocalData.fromJson(jsonDecode(data));
      localData.accessToken = null;
      localData.refreshToken = null;
      localData.accountMode = AccountMode.none;
      localData.isFirstTimeOpenApp = false;
      localData.isChosenFavorite = true;
      await _appPreferences.setString('localData', jsonEncode(localData.toJson()));
    }
  }
}