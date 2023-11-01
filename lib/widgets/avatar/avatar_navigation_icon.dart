import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class AvatarProfile extends StatelessWidget {
  final bool selected;

  const AvatarProfile({
    super.key,
    this.selected = false
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
      child: const CircleAvatar(
        radius: 15,
        backgroundImage: NetworkImage(
          'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
        )
      )
    );
  }
}
