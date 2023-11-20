import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/screens/organization/home/organization_home_screen.dart';
import 'package:unidy_mobile/screens/user/home/home_screen.dart';

enum EPopupMenuOption {
  logout,
  organizationMode,
  sponsorMode,
  volunteerMode
}

class IPopupMenuItem {
  EPopupMenuOption value;
  String label;
  IPopupMenuItem({ required this.value, required this.label });
}

class UnidyPopupMenu extends StatefulWidget {
  final List<IPopupMenuItem> popupMenuItems;

  const UnidyPopupMenu({
    super.key,
    required this.popupMenuItems,
  });

  @override
  State<UnidyPopupMenu> createState() => _UnidyPopupMenuState();
}

class _UnidyPopupMenuState extends State<UnidyPopupMenu> {
  IPopupMenuItem? selectedItem;
  AppPreferences appPreferences = GetIt.instance<AppPreferences>();

  void _handleSelect(IPopupMenuItem item) {
    switch(item.value) {
      case EPopupMenuOption.logout:
        appPreferences.clean();
        while(Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacementNamed(context, '/authentication/login');
        break;
      case EPopupMenuOption.organizationMode:
        appPreferences.setString('accountMode', 'organization');
        Navigator.push(context, MaterialPageRoute(builder: (context) => WillPopScope(child: const OrganizationHomeScreen(), onWillPop: () async => false )));
        break;
      case EPopupMenuOption.sponsorMode:
      case EPopupMenuOption.volunteerMode:
        appPreferences.setString('accountMode', 'user');
        Navigator.push(context, MaterialPageRoute(builder: (context) => WillPopScope(child: const HomeScreen(), onWillPop: () async => false )));
        break;
    }
  }

  List<PopupMenuItem<IPopupMenuItem>> _buildItems() {
    List<PopupMenuItem<IPopupMenuItem>> items = [];
    items = widget.popupMenuItems.map((IPopupMenuItem item) => PopupMenuItem<IPopupMenuItem>(
      value: item,
      child: Text(
        item.label,
        style: item.value == EPopupMenuOption.logout ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: ErrorColor.error400) : null,
      ),
    )).toList();

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<IPopupMenuItem>(
        initialValue: selectedItem,
        onSelected: _handleSelect,
        itemBuilder: (BuildContext context) => _buildItems()
    );
  }
}
