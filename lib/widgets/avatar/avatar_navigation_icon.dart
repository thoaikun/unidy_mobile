import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          width: 15,
          height: 15,
        )
      )
    );
  }
}
