import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unidy_mobile/bloc/network_detect_cubit.dart';
import 'package:unidy_mobile/config/themes/theme_config.dart';
import 'package:unidy_mobile/routes.dart';

import 'config/getit_config.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  configGetIt();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NetworkDetectCubit())
      ],
      child: MaterialApp(
        title: 'Unidy',
        theme: unidyThemeData,
        routes: routes,
        initialRoute: '/placeholder',
      )
    );
  }
}