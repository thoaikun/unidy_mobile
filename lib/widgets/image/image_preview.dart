import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

class ImagePreview extends StatelessWidget {
  final File file;
  final void Function()? onDelete;

  const ImagePreview({super.key, required this.file, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              file,
              width: double.infinity,
            ),
          ),
        ),
        Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              icon: const Icon(
                  Icons.cancel,
                  size: 25,
                  color: TextColor.textColor300
              ),
              onPressed: onDelete,
            )
        ),
      ],
    );
  }
}
