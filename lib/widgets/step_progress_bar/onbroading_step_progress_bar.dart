import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_color.dart';

class OnboardingStepProgressBar extends StatelessWidget {
  final int step;
  final int currentStep;

  const OnboardingStepProgressBar({
    super.key,
    required this.step,
    this.currentStep = 0
  });

  List<Widget> _buildStepIndicator() {
    List<Widget> result = [];

    for (int i=0; i < step; i++) {
      result.add(Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: i == currentStep ? PrimaryColor.primary500 : TextColor.textColor200,
          shape: BoxShape.circle
        ),
      ));
      
      if (i < step-1) {
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
