import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class RoleCard extends StatelessWidget {
  final List<Image> icons;
  final String title;
  final String description;
  final bool isSelected;
  final void Function()? onTap;

  const RoleCard({
    super.key,
    required this.icons,
    required this.title,
    required this.description,
    this.isSelected = false,
    this.onTap
  });

  BoxDecoration getContainerStyle() {
    return BoxDecoration(
      color: isSelected ? PrimaryColor.primary200 : Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isSelected ? PrimaryColor.primary500 : TextColor.textColor200,
        width: 1
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: getContainerStyle(),
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 500),
              child: isSelected ? icons[1] : icons[0],
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.textColor300),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
