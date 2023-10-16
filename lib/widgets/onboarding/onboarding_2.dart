import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/widgets/step_progress_bar/onbroading_step_progress_bar.dart';

class Onboarding2 extends StatelessWidget {
  final String illustrationUrl = 'assets/imgs/illustration/onboarding_2.svg';

  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(illustrationUrl),
          const SizedBox(height: 20),
          Text(
            'Thao tác đơn giản',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tham gia các chiến dịch chỉ với',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
              Text(
                'vài bước cơ bản, quản lý chiến dịch',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
              Text(
                'một cách hiệu quả',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
