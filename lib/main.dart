import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/network_detect_cubit.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/theme_config.dart';
import 'package:unidy_mobile/routes.dart';

import 'config/getit_config.dart';
import 'viewmodel/add_post_viewmodel.dart';
import 'viewmodel/dashboard_viewmodel.dart';
import 'viewmodel/navigation_viewmodel.dart';
import 'viewmodel/profile_viewmodel.dart';

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
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NavigationViewModel()),
          ChangeNotifierProvider(create: (_) => AddPostViewModel()),
          ChangeNotifierProvider(create: (_) => ProfileViewModel()),
          ChangeNotifierProvider(create: (_) => DashboardViewModel())
        ],
        child: MaterialApp(
          title: 'Unidy',
          theme: unidyThemeData,
          routes: routes,
          initialRoute: '/placeholder',
        ),
      )
    );
  }
}