import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/viewmodel/navigation_viewmodel.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_navigation_icon.dart';

class UnidyMainBottomNavigationBar extends StatefulWidget {
  const UnidyMainBottomNavigationBar({super.key});

  @override
  State<UnidyMainBottomNavigationBar> createState() => _UnidyMainBottomNavigationBarState();
}

class _UnidyMainBottomNavigationBarState extends State<UnidyMainBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<ProfileCubit>().state;

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
            icon: AvatarProfile(
              selected: navigationViewModal.currentScreen == 4,
              imageUrl: user.image ?? 'https://api.dicebear.com/7.x/initials/png?seed=${user.fullName}'
            ),
            label: 'Cá nhân'
          )
        ]
      ),
    );
  }
}


