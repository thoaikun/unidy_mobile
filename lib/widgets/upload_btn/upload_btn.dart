import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

class UploadButton extends StatelessWidget {
  final void Function()? onTap;
  const UploadButton({super.key, this.onTap});

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: PrimaryColor.primary500, width: 3, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(8),
      color: TextColor.textColor50
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: getBoxDecoration(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.image_rounded),
            SizedBox(height: 20),
            Text('Chọn ảnh')
          ],
        ),
      ),
    );
  }
}
