import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unidy_mobile/bloc/network_detect_cubit.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/theme_config.dart';
import 'package:unidy_mobile/screens/placeholder/placeholder_screen.dart';

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
        BlocProvider(create: (BuildContext context) => NetworkDetectCubit()),
        BlocProvider(create: (BuildContext context) => ProfileCubit())
      ],
      child: MaterialApp(
        title: 'Unidy',
        theme: unidyThemeData,
        home: const PlaceholderScreen(),
      )
    );
  }
}