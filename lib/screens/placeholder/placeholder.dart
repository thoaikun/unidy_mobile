import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/screens/user/home/home_screen.dart';

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({super.key});

  @override
  State<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  late Future<bool> hasLoginFuture;
  AppPreferences appPreferences = GetIt.instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    hasLoginFuture = isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: hasLoginFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) return const HomeScreen();
          return const LoginScreen();
        }
        return _buildPlaceHolder();
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

  Future<bool> isLogin() async {
    await Future.delayed(Duration(seconds: 2));
    String? accessToken = appPreferences.getString('accessToken');
    return accessToken == null ? false : true;
  }
}
