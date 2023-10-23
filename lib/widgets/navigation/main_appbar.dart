import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unidy_mobile/config/color_config.dart';
import 'package:unidy_mobile/widgets/popup_menu.dart';
import 'package:unidy_mobile/models/popup_menu_option_model.dart';
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
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_rounded),
        ),
        UnidyPopupMenu(
          popupMenuItems: [
            IPopupMenuItem(value: EPopupMenuOption.logout, label: 'Đăng xuất'),
            IPopupMenuItem(value: EPopupMenuOption.organizationMode, label: 'Quản lý tổ chức'),
            IPopupMenuItem(value: EPopupMenuOption.sponsorMode, label: 'Quản lý nhà hảo tâm'),
          ],
        )
      ],
    );
  }
}
