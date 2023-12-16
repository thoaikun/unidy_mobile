import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/viewmodel/add_post_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/dashboard_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/navigation_viewmodel.dart';
import 'package:unidy_mobile/screens/user/home/tabs/add_post.dart';
import 'package:unidy_mobile/screens/user/home/tabs/dashboard.dart';
import 'package:unidy_mobile/screens/user/home/tabs/friends.dart';
import 'package:unidy_mobile/screens/user/home/tabs/history.dart';
import 'package:unidy_mobile/screens/user/home/tabs/profile.dart';
import 'package:unidy_mobile/viewmodel/profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/navigation/bottom_navigation_bar.dart';
import 'package:unidy_mobile/widgets/navigation/main_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Widget> _screenOptions = const [
    Dashboard(),
    Friends(),
    AddPost(),
    History(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
        ChangeNotifierProvider(create: (_) => AddPostViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel())
      ],
      child: Consumer<NavigationViewModel>(
        builder: (BuildContext context, NavigationViewModel navigationViewModal, Widget? child) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(55),
              child: UnidyMainAppBar()
          ),
          bottomNavigationBar: const UnidyMainBottomNavigationBar(),
          body: _screenOptions[navigationViewModal.currentScreen]
        ),
      ),
    );
  }
}
