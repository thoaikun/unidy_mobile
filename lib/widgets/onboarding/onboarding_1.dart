import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/widgets/step_progress_bar/onbroading_step_progress_bar.dart';

class Onboarding1 extends StatelessWidget {
  final String illustrationUrl = 'assets/imgs/illustration/onboarding_1.png';

  const Onboarding1({super.key});

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
            'Chung tay đóng góp',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Giúp đỡ các hoàn cảnh khó khăn',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
              Text(
                'bằng cách hỗ trợ các chiến dịch từ thiện',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
