import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unidy_mobile/bloc/network_detect_cubit.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/theme_config.dart';
import 'package:unidy_mobile/firebase_options.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/screens/placeholder/placeholder_screen.dart';
import 'package:unidy_mobile/screens/user/donation/donation_success_screen.dart';
import 'package:unidy_mobile/utils/local_notification.dart';

import 'config/getit_config.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: ".env");
  configGetIt();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  LocalNotification localNotification = LocalNotification();
  await localNotification.initLocalNotifications();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    localNotification.displayNotification(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    localNotification.displayNotification(message);
  });
  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) => runApp(const MyApp()));
}

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  LocalNotification localNotification = LocalNotification();
  await localNotification.initLocalNotifications();
  localNotification.displayNotification(message);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
  }

  void initDynamicLinks() async {
    // Set up listener for dynamic links
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? data) {
      if (data != null) {
        // Handle the dynamic link here
        handleDynamicLink(data.link);
      }
    });

    // Check if the app was opened by a dynamic link
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      // Handle the initial dynamic link
      handleDynamicLink(initialLink.link);
    }
  }

  void handleDynamicLink(Uri link) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => DonationSuccessScreen()));
  }


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
        navigatorKey: navigatorKey,
        routes: {
          '/login': (context) => const LoginScreen()
        },
      )
    );
  }
}