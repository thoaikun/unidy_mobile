import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/widgets/onboarding/onboarding_1.dart';
import 'package:unidy_mobile/widgets/onboarding/onboarding_2.dart';
import 'package:unidy_mobile/widgets/onboarding/onboarding_3.dart';
import 'package:unidy_mobile/widgets/progress_bar/dot_progress_bar.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Widget> onboardings = [
    const Onboarding1(),
    const Onboarding2(),
    const Onboarding3()
  ];
  int currentStep = 0;
  String stepLabel = 'Tiếp theo';

  @override
  void initState() {
    super.initState();
    currentStep = 0;
  }

  void _handleSkip() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _handleNextStep() {
    if (currentStep < onboardings.length - 2) {
      setState(() {
        currentStep += 1;
      });
    }
    else if (currentStep == onboardings.length - 2) {
      setState(() {
        currentStep += 1;
        stepLabel = 'Bắt đầu';
      });
    }
    else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children:[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.07,
              right: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _handleSkip,
                        child: Text(
                          'Bỏ qua',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TextColor.textColor300),
                        )
                    ),
                  ]
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: onboardings[currentStep],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.08,
              left: (MediaQuery.of(context).size.width - 240) * 0.5,
              child: Column(
                children: [
                  DotProgressBar(max: onboardings.length, current: currentStep),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: FilledButton(
                        onPressed: _handleNextStep,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              stepLabel,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 15,)
                          ],
                        )
                    ),
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
