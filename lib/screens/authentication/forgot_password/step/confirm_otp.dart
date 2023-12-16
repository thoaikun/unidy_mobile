import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/viewmodel/forgot_password_viewmodel.dart';
import 'package:unidy_mobile/widgets/button/waiting_btn.dart';
import 'package:unidy_mobile/widgets/input/otp_input.dart';

class ConfirmOtp extends StatelessWidget {
  final String logoImage = 'assets/imgs/logo/logo_1.png';
  const ConfirmOtp({super.key});

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
                      'Xác nhận OTP',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      children: [
                        Text(
                          'Nhập mã OTP được gửi qua email ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: TextColor.textColor300),
                        ),
                        Text(
                          forgotPasswordViewModel.email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: PrimaryColor.primary500),
                        ),
                        Text(
                          'của bạn.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: TextColor.textColor300),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                OtpInput(numberOfDigit: 6, onComplete: forgotPasswordViewModel.setOtpValue),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child:
                  FilledButton(
                    onPressed: () => forgotPasswordViewModel.onClickConfirmOtp(),
                    child: const Text('Xác nhận')
                  ),
                ),
                Center(
                  child: WaitingButton(
                    text: 'Gửi lại',
                    onPressed: () => forgotPasswordViewModel.onClickResendOtp(),
                    duration: const Duration(seconds: 5)
                  )
                )
              ],
            ),
          ],
        );
      }
    );
  }
}
