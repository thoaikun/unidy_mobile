import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unidy_mobile/config/themes/theme_config.dart';
import 'package:unidy_mobile/routes/routes.dart';

import 'config/getit_config.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  configGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unidy',
      theme: unidyThemeData,
      routes: routes,
      initialRoute: '/placeholder',
    );
  }
}