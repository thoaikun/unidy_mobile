import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/viewmodel/signup_viewmodel.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class InformationStep extends StatelessWidget {
  const InformationStep({super.key});

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
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.nameController,
              label: 'Tên',
              placeholder: 'Nhập tên của bạn',
              error: signUpViewModel.nameError,
              prefixIcon: const Icon(Icons.person_2_rounded)
            ),
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.dobController,
              label: 'Ngày sinh',
              error: signUpViewModel.dobError,
              onTap: () => signUpViewModel.selectDate(context),
              prefixIcon: const Icon(Icons.calendar_month_rounded),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.sexController,
              label: 'Giới tính',
              placeholder: 'Thêm giới tính của bạn',
              error: signUpViewModel.sexError,
              prefixIcon: const Icon(Icons.transgender_rounded)
            ).dropdown(context, ['Nam', 'Nữ', 'Khác'], signUpViewModel.setUseSex),
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.phoneController,
              label: 'Số điện thoại',
              error: signUpViewModel.phoneError,
              numberKeyboard: true,
              prefixIcon: const Icon(Icons.phone_android_rounded),
            ),
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.jobController,
              label: 'Nghề nghiệp',
              error: signUpViewModel.jobError,
              prefixIcon: const Icon(Icons.cases_rounded)
            ),
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.workPlaceController,
              label: 'Nơi công tác',
              error: signUpViewModel.workplaceError,
              prefixIcon: const Icon(Icons.business),
            )
          ],
        );
      }
    );
  }
}
