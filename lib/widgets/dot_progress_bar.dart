import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

class DotProgressBar extends StatelessWidget {
  final int max;
  final int current;
  final double dotSize;

  const DotProgressBar({
    super.key,
    required this.max,
    this.current = 0,
    this.dotSize = 10
  });

  List<Widget> _buildStepIndicator() {
    List<Widget> result = [];

    for (int i=0; i < max; i++) {
      result.add(Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          color: i == current ? PrimaryColor.primary500 : TextColor.textColor200,
          shape: BoxShape.circle
        ),
      ));
      
      if (i < max-1) {
        result.add(const SizedBox(width: 10));
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildStepIndicator()
    );
  }
}
