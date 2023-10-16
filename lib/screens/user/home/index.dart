import 'package:flutter/material.dart';
import 'package:unidy_mobile/screens/user/home/add_post.dart';
import 'package:unidy_mobile/screens/user/home/dashboard.dart';
import 'package:unidy_mobile/screens/user/home/friends.dart';
import 'package:unidy_mobile/screens/user/home/history.dart';
import 'package:unidy_mobile/screens/user/home/profile.dart';
import 'package:unidy_mobile/view_model/navigation_view_model.dart';
import 'package:unidy_mobile/widgets/input/input.dart';
import 'package:unidy_mobile/widgets/navigation/bottom_navigation_bar.dart';
import 'package:unidy_mobile/widgets/navigation/main_appbar.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (_) => NavigationViewModel())
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
