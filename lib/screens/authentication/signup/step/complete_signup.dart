import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';

class CompleteSignUpStep extends StatelessWidget {
  const CompleteSignUpStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đăng ký thành công',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              'Tài khoản của bạn đã được tạo, hãy hòa mình vào thế giới của chúng tôi ngay.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TextColor.textColor300),
            )
          ],
        ),
      ],
    );;
  }
}
