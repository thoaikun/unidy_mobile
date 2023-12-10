import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/account_mode_model.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/screens/organization/home/organization_home_screen.dart';
import 'package:unidy_mobile/screens/user/home/home_screen.dart';

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({super.key});

  @override
  State<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  AppPreferences appPreferences = GetIt.instance<AppPreferences>();
  HttpClient httpClient = GetIt.instance<HttpClient>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isLogin(),
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case AccountMode.user:
          case AccountMode.sponsor:
            return WillPopScope(child: const HomeScreen(), onWillPop: () async => false );
          case AccountMode.organization:
            return WillPopScope(child: const OrganizationHomeScreen(), onWillPop: () async => false );
          case AccountMode.none:
            return WillPopScope(child: const LoginScreen(), onWillPop: () async => false );
          default:
            return _buildPlaceHolder();
        }
      }
    );
  }

  Widget _buildPlaceHolder() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/logo/logo_1.png',
              width: 60,
            ),
            const SizedBox(height: 30),
            const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(strokeWidth: 5)
            )
          ],
        ),
      ),
    );
  }

  Future<AccountMode> isLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    String? accessToken = appPreferences.getString('accessToken');
    AccountMode accountMode = accountModeFromString(appPreferences.getString('accountMode')) ?? AccountMode.none;
    if (accessToken != null) {
      httpClient.addHeader('Authorization', 'Bearer $accessToken');
    }
    return accountMode;
  }
}
