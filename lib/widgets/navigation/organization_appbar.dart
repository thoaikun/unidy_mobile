import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/screens/organization/edit_campaign/edit_campaign_screen.dart';
import 'package:unidy_mobile/screens/user/notification/notification_screen.dart';
import 'package:unidy_mobile/viewmodel/notification_viewmodel.dart';
import 'package:unidy_mobile/widgets/popup_menu.dart';
import 'package:unidy_mobile/widgets/search/search_delegate.dart';

class UnidyOrganizationAppBar extends StatefulWidget {
  const UnidyOrganizationAppBar({super.key});

  @override
  State<UnidyOrganizationAppBar> createState() => _UnidyOrganizationAppBarState();
}

class _UnidyOrganizationAppBarState extends State<UnidyOrganizationAppBar> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationViewModel())
      ],
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/imgs/logo/logo_3.png',
          width: 180,
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditCampaignScreen())),
            icon: const Icon(Icons.add_rounded, color: PrimaryColor.primary500),
          ),
          Consumer<NotificationViewModel>(
              builder: (BuildContext context, NotificationViewModel notificationViewModel, Widget? child) {
                return IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen())),
                  icon: const Badge(
                      label: Text('1'),
                      alignment: Alignment.topRight,
                      child: Icon(Icons.notifications_rounded)
                  ),
                );
              }
          ),
          UnidyPopupMenu(
            popupMenuItems: [
              IPopupMenuItem(value: EPopupMenuOption.volunteerMode, label: 'Thoát chế độ quản lý'),
              IPopupMenuItem(value: EPopupMenuOption.logout, label: 'Đăng xuất'),
            ],
          )
        ],
      ),
    );
  }
}
