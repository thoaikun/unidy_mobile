import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class AvatarProfile extends StatelessWidget {
  final bool selected;
  String imageUrl;

  AvatarProfile({
    super.key,
    this.selected = false,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: selected ? PrimaryColor.primary500 : TextColor.textColor200,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.all(2),
      child: CircleAvatar(
        radius: 15,
        backgroundImage: NetworkImage(imageUrl)
      )
    );
  }
}
