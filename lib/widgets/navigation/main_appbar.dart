import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/screens/user/notification/notification_screen.dart';
import 'package:unidy_mobile/viewmodel/notification_viewmodel.dart';
import 'package:unidy_mobile/widgets/popup_menu.dart';
import 'package:unidy_mobile/widgets/search/search_delegate.dart';

class UnidyMainAppBar extends StatefulWidget {
  const UnidyMainAppBar({super.key});

  @override
  State<UnidyMainAppBar> createState() => _UnidyMainAppBarState();
}

class _UnidyMainAppBarState extends State<UnidyMainAppBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/imgs/logo/logo_2.png',
        width: 85,
      ),
      actions: [
        IconButton(
          onPressed: () => showSearch(context: context, delegate: UnidySearchDelegate()),
          icon: const Icon(Icons.search_rounded, color: PrimaryColor.primary500),
        ),
        Consumer<NotificationViewModel>(
          builder: (BuildContext context, NotificationViewModel notificationViewModel, Widget? child) {
            return IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen())),
              icon: Badge(
                isLabelVisible: notificationViewModel.totalUnseen > 0,
                label: Text(notificationViewModel.totalUnseen.toString()),
                alignment: Alignment.topRight,
                child: const Icon(Icons.notifications_rounded)
              ),
            );
          }
        ),
        UnidyPopupMenu(
          popupMenuItems: [
            IPopupMenuItem(value: EPopupMenuOption.logout, label: 'Đăng xuất'),
          ],
        )
      ],
    );
  }
}
