import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/viewmodel/forgot_password_viewmodel.dart';
import 'package:unidy_mobile/widgets/input.dart';

class ConfirmEmail extends StatelessWidget {
  final String logoImage = 'assets/imgs/logo/logo_1.png';
  const ConfirmEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordViewModel>(
      builder: (BuildContext context, ForgotPasswordViewModel forgotPasswordViewModel, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              logoImage,
              width: 70,
              height: 70,
            ),
            const SizedBox(height: 45),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quên mật khẩu',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Nhập email để chúng tôi gửi thông tin thay đổi mật khẩu cho bạn',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: TextColor.textColor300),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Input(
                    label: 'Email',
                    prefixIcon: Icon(Icons.email_rounded)
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child:
                  FilledButton(
                      onPressed: () => forgotPasswordViewModel.setCurrentStep(forgotPasswordViewModel.currentStep + 1),
                      child: const Text('Xác nhận')
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}