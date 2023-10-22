import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/color_config.dart';
import 'package:unidy_mobile/controller/signup_controller.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class CreateAccountStep extends StatelessWidget {
  const CreateAccountStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (BuildContext context, SignUpViewModel signUpViewModel, Widget? child) {
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
            Input(
                controller: signUpViewModel.emailController,
                label: 'Email',
                placeholder: 'Nhập email của bạn',
                prefixIcon: Icon(Icons.email_rounded)
            ),
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.passwordController,
              label: 'Mật khẩu',
              placeholder: 'Nhập mật khẩu của bạn',
              prefixIcon: const Icon(Icons.key_rounded),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_rounded)
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Text(
              'Mật khẩu phải gồm:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
            ),
            const SizedBox(height: 5),
            Text(
              '1. Ký tự in hoa.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
            ),
            Text(
              '2. Ký tự in thường.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
            ),
            Text(
              '3. Chữ số.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
            ),
            Text(
              '4. Ký tự đặt biệt.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
            )
          ],
        );
      }
    );
  }
}