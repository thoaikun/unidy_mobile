import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/viewmodel/navigation_viewmodel.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_navigation_icon.dart';

class OrganizationBottomNavigationBar extends StatefulWidget {
  const OrganizationBottomNavigationBar({super.key});

  @override
  State<OrganizationBottomNavigationBar> createState() => _OrganizationBottomNavigationBarState();
}

class _OrganizationBottomNavigationBarState extends State<OrganizationBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (BuildContext context, NavigationViewModel navigationViewModal, Widget? child) => BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          onTap: navigationViewModal.onTap,
          currentIndex: navigationViewModal.currentScreen,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Bảng tin'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.monitor_heart_outlined),
                label: 'Chiến dịch'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded),
                label: 'Tin nhắn'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.public_rounded),
                label: 'Tổ chức'
            )
          ]
      ),
    );
  }
}


