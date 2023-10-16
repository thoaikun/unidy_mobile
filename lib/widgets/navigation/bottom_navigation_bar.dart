import 'package:flutter/material.dart';
import 'package:unidy_mobile/view_model/navigation_view_model.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_profile.dart';
import 'package:provider/provider.dart';

class UnidyBottomNavigationBar extends StatefulWidget {
  const UnidyBottomNavigationBar({super.key});

  @override
  State<UnidyBottomNavigationBar> createState() => _UnidyBottomNavigationBarState();
}

class _UnidyBottomNavigationBarState extends State<UnidyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (BuildContext context, NavigationViewModel navigationViewModal, Widget? child) => BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: navigationViewModal.onTap,
        currentIndex: navigationViewModal.currentScreen,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Bảng tin'
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Bạn bè'
          ),
          const  BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Bài viết'
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: 'Lịch sử'
          ),
          BottomNavigationBarItem(
            icon: AvatarProfile(selected: navigationViewModal.currentScreen == 4),
            label: 'Cá nhân'
          )
        ]
      ),
    );
  }
}
