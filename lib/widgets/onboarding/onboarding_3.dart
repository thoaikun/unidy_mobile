import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unidy_mobile/config/color_config.dart';
import 'package:unidy_mobile/widgets/progress_bar/dot_progress_bar.dart';

class Onboarding3 extends StatelessWidget {
  final String illustrationUrl = 'assets/imgs/illustration/onboarding_3.png';

  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(illustrationUrl),
          const SizedBox(height: 20),
          Text(
            'Minh bạch, rõ ràng',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thông tin chiến dịch, số tiền nhận',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
              Text(
                'được, các khoản đã chi được kê',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
              Text(
                'khai một cách rõ ràng',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
