import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/viewmodel/forgot_password_viewmodel.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class EnterNewPassword extends StatelessWidget {
  final String logoImage = 'assets/imgs/logo/logo_1.png';

  const EnterNewPassword({super.key});

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
                      'Nhập mật khẩu mới',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Nhập mật khẩu mới để tiếp tục tham gia với chúng tôi.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: TextColor.textColor300),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Input(
                  controller: forgotPasswordViewModel.newPasswordController,
                  label: 'Mật khẩu mới',
                  error: forgotPasswordViewModel.passwordError,
                  prefixIcon: const Icon(Icons.key_rounded),
                  obscureText: !forgotPasswordViewModel.showPassword,
                ),
                const SizedBox(height: 15),
                Input(
                  controller: forgotPasswordViewModel.confirmNewPasswordController,
                  label: 'Xác nhận mật khẩu mới',
                  error: forgotPasswordViewModel.confirmPasswordError,
                  prefixIcon: const Icon(Icons.lock_rounded),
                  obscureText: !forgotPasswordViewModel.showPassword,
                ),
                const SizedBox(height: 15),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Checkbox(
                      value: forgotPasswordViewModel.showPassword,
                      onChanged: (value) => forgotPasswordViewModel.toggleShowPassword(value)
                    ),
                    const Text('Hiển thị mật khẩu')
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child:
                  FilledButton(
                      onPressed: () => forgotPasswordViewModel.onClickConfirmNewPassword(),
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
