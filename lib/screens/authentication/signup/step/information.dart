import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';
import 'package:unidy_mobile/viewmodel/signup_viewmodel.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class InformationStep extends StatelessWidget {
  const InformationStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ERole? role = Provider.of<SignUpViewModel>(context, listen: false).selectedRole;

    switch (role) {
      case ERole.volunteer:
      case ERole.sponsor:
        return _buildForUser();
      case ERole.organization:
        return _buildForOrganization();
      default:
        return const SizedBox();
    }
  }

  Widget _buildForUser() {
    return Consumer<SignUpViewModel>(
      builder: (BuildContext context, SignUpViewModel signUpViewModel, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin cá nhân',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Hãy cho chúng tôi biết thêm về bạn',
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

  Widget _buildForOrganization() {
    return Consumer<SignUpViewModel>(
      builder: (BuildContext context, SignUpViewModel signUpViewModel, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin tổ chức',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Hãy cho chúng tôi biết thêm về tổ chức của bạn',
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
                label: 'Tên tổ chức',
                placeholder: 'Nhập tên tổ chức',
                error: signUpViewModel.nameError,
                prefixIcon: const Icon(Icons.person_2_rounded)
            ),
            const SizedBox(height: 20),
            Input(
              controller: signUpViewModel.dobController,
              label: 'Ngày thành lập',
              error: signUpViewModel.dobError,
              onTap: () => signUpViewModel.selectDate(context),
              prefixIcon: const Icon(Icons.calendar_month_rounded),
              readOnly: true,
            ),
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
                controller: signUpViewModel.workPlaceController,
                label: 'Địa chỉ',
                error: signUpViewModel.workplaceError,
                prefixIcon: const Icon(Icons.location_on_rounded)
            )
          ],
        );
      }
    );
  }
}
