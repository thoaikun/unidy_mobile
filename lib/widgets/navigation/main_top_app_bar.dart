import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/config/config_theme.dart';
import 'package:unidy_mobile/widgets/search/search_delegate.dart';

class MainTopAppBar {

  void _handleClick(String value) {
    print(value);
  }

  AppBar render(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      shadowColor: unidyColorScheme.shadow,
      title: SvgPicture.asset(
        'assets/imgs/logo/logo_2.svg',
        width: 100,
        height: 30,
      ),
      actions: [
        IconButton(
            onPressed: () => showSearch(context: context, delegate: UnidySearchDelegate()),
            icon: const Icon(Icons.search, color: PrimaryColor.primary500)
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded)
        ),
        PopupMenuButton(
          onSelected: _handleClick,
          itemBuilder: (BuildContext context) {
            return {'Logout', 'Settings'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          }
        )
      ],
    );
  }
}
