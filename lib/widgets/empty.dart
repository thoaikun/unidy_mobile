import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class Empty extends StatelessWidget {
  final String? description;
  const Empty({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/imgs/icon/empty-box.png', width: 100, height: 100, color: TextColor.textColor300),
        const SizedBox(height: 20,),
        Text(
          description ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
        )
      ]
    );
  }
}
