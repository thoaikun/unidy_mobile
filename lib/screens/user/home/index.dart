import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/controller/add_post_controller.dart';
import 'package:unidy_mobile/controller/navigation_controller.dart';
import 'package:unidy_mobile/screens/user/home/tabs/add_post.dart';
import 'package:unidy_mobile/screens/user/home/tabs/dashboard.dart';
import 'package:unidy_mobile/screens/user/home/tabs/friends.dart';
import 'package:unidy_mobile/screens/user/home/tabs/history.dart';
import 'package:unidy_mobile/screens/user/home/tabs/profile.dart';
import 'package:unidy_mobile/widgets/navigation/bottom_navigation_bar.dart';
import 'package:unidy_mobile/widgets/navigation/main_appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
        ChangeNotifierProvider(create: (_) => AddPostController())
      ],
      child: Consumer<NavigationViewModel>(
        builder: (BuildContext context, NavigationViewModel navigationViewModal, Widget? child) => Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(55),
                child: UnidyMainAppBar()
            ),
            bottomNavigationBar: const UnidyBottomNavigationBar(),
            body: _screenOptions[navigationViewModal.currentScreen]
        ),
      ),
    );
  }
}
