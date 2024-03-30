import 'package:flutter/material.dart';

class CircleProgressBar extends StatelessWidget {
  final Color? backgroundColor;
  final Color? color;
  final int max;
  final int value;
  final double radius;
  final String? label;

  const CircleProgressBar({
    super.key,
    required this.max,
    required this.value,
    required this.radius,
    this.color,
    this.backgroundColor,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: radius,
          height: radius,
          child: CircularProgressIndicator(
            backgroundColor: backgroundColor,
            color: color,
            value: value / max,
            strokeWidth: 15,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              label ?? '$value',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
            ),
          ),
        ),
      ],
    );
  }
}
