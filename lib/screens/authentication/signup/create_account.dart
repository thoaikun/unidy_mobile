import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class CreateAccountStep extends StatelessWidget {
  const CreateAccountStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đăng ký tài khoản',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(
              'Nhập email và mật khẩu cho tài khoản bạn',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TextColor.textColor300),
            )
          ],
        ),
        const SizedBox(height: 35),
        const Input(
            label: 'Email',
            placeholder: 'Nhập email của bạn',
            icon: Icon(Icons.email_rounded)
        ),
        const SizedBox(height: 20),
        const Input(
          label: 'Mật khẩu',
          placeholder: 'Nhập mật khẩu của bạn',
          type: InputType.password,
          icon: Icon(Icons.key_rounded),
        )
      ],
    );
  }
}
