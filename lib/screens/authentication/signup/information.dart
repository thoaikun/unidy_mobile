import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/config_color.dart';
import 'package:unidy_mobile/view_model/signup_view_model.dart';
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
            const Input(
                label: 'Tên',
                placeholder: 'Nhập tên của bạn',
                icon: Icon(Icons.person_2_rounded)
            ),
            const SizedBox(height: 20),
            Input(
              label: 'Ngày sinh',
              onTap: () => signUpViewModel.selectDate(context),
              icon: const Icon(Icons.calendar_month_rounded),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            const Input(
                label: 'Giới tính',
                placeholder: 'Thêm giới tính của bạn',
                icon: Icon(Icons.transgender_rounded)
            ),
            const SizedBox(height: 20),
            const Input(
              label: 'Số điện thoại',
              type: InputType.password,
              icon: Icon(Icons.phone_android_rounded),
            ),
            const SizedBox(height: 20),
            const Input(
                label: 'Nghề nghiệp',
                icon: Icon(Icons.cases_rounded)
            ),
            const SizedBox(height: 20),
            const Input(
              label: 'Nơi công tác',
              type: InputType.password,
              icon: Icon(Icons.business),
            )
          ],
        );
      }
    );
  }
}
