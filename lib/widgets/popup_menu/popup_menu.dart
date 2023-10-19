import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/models/model_popup_menu_option.dart';

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

  void _handleSelect(IPopupMenuItem item) {
    switch(item.value) {
      case EPopupMenuOption.logout:
        print('logout');
        break;
      case EPopupMenuOption.organizationMode:
      case EPopupMenuOption.sponsorMode:
      case EPopupMenuOption.volunteerMode:
        print('change mode');
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
