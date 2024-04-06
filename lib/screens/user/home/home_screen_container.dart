import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/viewmodel/user/home/add_post_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/user/home/dashboard_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/navigation_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/user/home/friends_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/user/home/history_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/user/home/profile_viewmodel.dart';

import 'home_screen.dart';

class HomeScreenContainer extends StatefulWidget {
  const HomeScreenContainer({super.key});

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileViewModel(context: context)),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
        ChangeNotifierProvider(create: (_) => AddPostViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => FriendsViewModel()),
        ChangeNotifierProvider(create: (_) => HistoryViewModel()),
      ],
      child: const HomeScreen(),
    );
  }
}
