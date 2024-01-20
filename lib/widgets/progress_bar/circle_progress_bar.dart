import 'package:flutter/material.dart';

class CircleProgressBar extends StatelessWidget {
  final Color? backgroundColor;
  final Color? color;
  final double max;
  final double value;
  final double radius;

  const CircleProgressBar({
    super.key,
    required this.max,
    required this.value,
    required this.radius,
    this.color,
    this.backgroundColor
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
              '$value',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
            ),
          ),
        ),
      ],
    );
  }
}
