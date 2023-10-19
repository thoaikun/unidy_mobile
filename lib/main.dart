import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_theme.dart';
import 'package:unidy_mobile/routes/routes.dart';
import 'config/config_getit.dart';

void main() {
  configGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isFirstTime = true;

    return MaterialApp(
      title: 'Unidy',
      theme: unidyThemeData,
      routes: routes,
      initialRoute: !isFirstTime ? '/' : '/authentication/signup',
    );
  }
}