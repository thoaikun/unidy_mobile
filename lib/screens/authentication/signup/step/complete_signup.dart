import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';
import 'package:unidy_mobile/viewmodel/signup_viewmodel.dart';

class CompleteSignUpStep extends StatelessWidget {
  const CompleteSignUpStep({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpViewModel signUpViewModel = Provider.of<SignUpViewModel>(context, listen: true);
    String successMessage = '';
    if (signUpViewModel.selectedRole == ERole.volunteer) {
      successMessage = 'Tài khoản của bạn đã được tạo, hãy hòa mình vào thế giới của chúng tôi ngay.';
    } else {
      successMessage = 'Yêu cầu đã được ghi nhận, chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để hoàn thành thủ tục đăng ký.';
    }

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
              successMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TextColor.textColor300),
            )
          ],
        ),
      ],
    );
  }
}
