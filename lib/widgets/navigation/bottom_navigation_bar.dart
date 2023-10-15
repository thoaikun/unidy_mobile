import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_profile.dart';

class UnidyBottomNavigationBar extends StatefulWidget {
  const UnidyBottomNavigationBar({super.key});

  @override
  State<UnidyBottomNavigationBar> createState() => _UnidyBottomNavigationBarState();
}

class _UnidyBottomNavigationBarState extends State<UnidyBottomNavigationBar> {
  int currentScreen = 0;

  void _handleDestinationSelected(int screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      onTap: _handleDestinationSelected,
      currentIndex: currentScreen,
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
          icon: AvatarProfile(selected: currentScreen == 4),
          label: 'Cá nhân'
        )
      ]
    );
  }
}
