import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_theme.dart';
import 'package:unidy_mobile/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unidy',
      theme: unidyThemeData,
      routes: routes,
      initialRoute: '/',
    );
  }
}