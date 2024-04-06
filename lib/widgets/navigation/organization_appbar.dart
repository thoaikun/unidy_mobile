import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/screens/organization/edit_campaign/edit_campaign_screen_container.dart';
import 'package:unidy_mobile/widgets/popup_menu.dart';

class UnidyOrganizationAppBar extends StatefulWidget {
  const UnidyOrganizationAppBar({super.key});

  @override
  State<UnidyOrganizationAppBar> createState() => _UnidyOrganizationAppBarState();
}

class _UnidyOrganizationAppBarState extends State<UnidyOrganizationAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Image.asset(
        'assets/imgs/logo/logo_3.png',
        width: 180,
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditCampaignScreenContainer())),
          icon: const Icon(Icons.add_rounded, color: PrimaryColor.primary500),
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
