import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/models/notification_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/viewmodel/navigation_viewmodel.dart';
import 'package:unidy_mobile/screens/user/home/tabs/add_post.dart';
import 'package:unidy_mobile/screens/user/home/tabs/dashboard.dart';
import 'package:unidy_mobile/screens/user/home/tabs/friends.dart';
import 'package:unidy_mobile/screens/user/home/tabs/history.dart';
import 'package:unidy_mobile/screens/user/home/tabs/profile.dart';
import 'package:unidy_mobile/viewmodel/user/home/profile_viewmodel.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (BuildContext context, NavigationViewModel navigationViewModal, Widget? child) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: UnidyMainAppBar()
        ),
        bottomNavigationBar: const UnidyMainBottomNavigationBar(),
        body: _screenOptions[navigationViewModal.currentScreen]
      ),
    );
  }
}
