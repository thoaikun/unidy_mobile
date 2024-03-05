import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/viewmodel/signup_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/role_card.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';

class SelectRoleStep extends StatelessWidget {
  const SelectRoleStep({super.key});

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
                  'Bạn là ...',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Chọn tài khoản mà bạn muốn đăng ký',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: TextColor.textColor300),
                )
              ],
            ),
            const SizedBox(height: 35),
            Column(
                children: [
                  RoleCard(
                    icons: [
                      Image.asset('assets/imgs/icon/role_volunteer_unselected.png', scale: 2.5),
                      Image.asset('assets/imgs/icon/role_volunteer_selected.png', scale: 2.5),
                    ],
                    title: 'Tình nguyện viên',
                    description: 'Tham gia các chương trình từ thiện',
                    isSelected: signUpViewModel.selectedRole == ERole.volunteer ,
                    onTap: () => signUpViewModel.setUserRole(ERole.volunteer),
                  ),
                  const SizedBox(height: 20),
                  RoleCard(
                    icons: [
                      Image.asset('assets/imgs/icon/role_sponsor_unselected.png', scale: 2.5),
                      Image.asset('assets/imgs/icon/role_sponsor_selected.png', scale: 2.5),
                    ],
                    title: 'Nhà hảo tâm',
                    description: 'Tài trợ cho các chương trình từ thiện',
                    isSelected: signUpViewModel.selectedRole == ERole.sponsor ,
                    onTap: () => signUpViewModel.setUserRole(ERole.sponsor),
                  ),
                  const SizedBox(height: 20),
                  RoleCard(
                    icons: [
                      Image.asset('assets/imgs/icon/role_organization_unselected.png', scale: 2.5),
                      Image.asset('assets/imgs/icon/role_organization_selected.png', scale: 2.5),
                    ],
                    title: 'Nhà tổ chức',
                    description: 'Tổ chức các hoạt động từ thiện',
                    isSelected: signUpViewModel.selectedRole == ERole.organization ,
                    onTap: () => signUpViewModel.setUserRole(ERole.organization),
                  ),
                ]
            )
          ],
        );
      }
    );
  }
}
