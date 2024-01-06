import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/viewmodel/edit_profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(widget.user, context: context),
      child: Consumer<EditProfileViewModel>(
          builder: (BuildContext context, EditProfileViewModel editProfileViewModel, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chỉnh sửa tài khoản'),
              actions: [
                TextButton.icon(
                  onPressed: () {
                      editProfileViewModel.handleUpdateProfile();

                      Map<String, dynamic> payload = {
                        'fullName': editProfileViewModel.user?.fullName,
                        'address': editProfileViewModel.user?.address,
                        'phone': editProfileViewModel.user?.phone,
                        'sex': editProfileViewModel.user?.sex,
                        'job': editProfileViewModel.user?.job,
                        'role': editProfileViewModel.user?.role,
                        'dayOfBirth': editProfileViewModel.user?.dayOfBirth,
                        'workLocation': editProfileViewModel.user?.workLocation,
                      };
                      context.read<ProfileCubit>().changeProfile(payload);
                    },
                  icon: const Icon(Icons.check_rounded, color: PrimaryColor.primary500),
                  label: const Text('Lưu'),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Visibility(
                  visible: editProfileViewModel.loading,
                  child: LinearProgressIndicator(),
                ),
              )
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                slivers: [
                  _buildAvatarForm(),
                  _buildWallpaperForm(),
                  _buildInformationForm()
                ],
              ),
            )
          );
        }
      ),
    );
  }

  Widget _buildInformationForm() {
    return SliverToBoxAdapter(
      child: Consumer<EditProfileViewModel>(
        builder: (BuildContext context, EditProfileViewModel editProfileViewModel, Widget? child) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Thông tin cá nhân',
                    style: Theme.of(context).textTheme.bodyLarge
                ),
                const SizedBox(height: 10),
                Input(
                  controller: editProfileViewModel.nameController,
                  label: 'Tên',
                  error: editProfileViewModel.nameError,
                  prefixIcon: const Icon(Icons.person_2_rounded)
                ),
                const SizedBox(height: 20),
                Input(
                  controller: editProfileViewModel.dobController,
                  label: 'Ngày sinh',
                  error: editProfileViewModel.dobError,
                  prefixIcon: const Icon(Icons.calendar_month_rounded),
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                Input(
                  controller: editProfileViewModel.sexController,
                  label: 'Giới tính',
                  error: editProfileViewModel.sexError,
                  prefixIcon: const Icon(Icons.transgender_rounded)
                ).dropdown(context, ['Nam', 'Nữ', 'Khác'], null),
                const SizedBox(height: 20),
                Input(
                  controller: editProfileViewModel.phoneController,
                  label: 'Số điện thoại',
                  error: editProfileViewModel.phoneError,
                  numberKeyboard: true,
                  prefixIcon: const Icon(Icons.phone_android_rounded),
                ),
                const SizedBox(height: 20),
                Input(
                  controller: editProfileViewModel.jobController,
                  label: 'Nghề nghiệp',
                  error: editProfileViewModel.jobError,
                  prefixIcon: const Icon(Icons.cases_rounded)
                ),
                const SizedBox(height: 20),
                Input(
                  controller: editProfileViewModel.workPlaceController,
                  label: 'Nơi công tác',
                  error: editProfileViewModel.workplaceError,
                  prefixIcon: const Icon(Icons.business),
                ),
                const SizedBox(height: 40)
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildAvatarForm() {
    return SliverToBoxAdapter(
      child: Consumer<EditProfileViewModel>(
        builder: (BuildContext context, EditProfileViewModel editProfileViewModel, Widget? widget) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ảnh đại diện',
                      style: Theme.of(context).textTheme.bodyLarge
                    ),
                    TextButton.icon(
                      onPressed: () {
                        editProfileViewModel.handleAddImage();
                        context.read<ProfileCubit>().changeProfileImage(editProfileViewModel.previewUploadedImagePath!);
                      },
                      icon: const Icon(Icons.edit, size: 18,),
                      label: const Text('Thay đổi'),
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(Theme.of(context).textTheme.labelMedium),
                        padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(5, 0, 0, 0))
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: PrimaryColor.primary500,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(
                     editProfileViewModel.previewUploadedImagePath ?? editProfileViewModel.user?.image ?? 'https://api.dicebear.com/7.x/initials/png?seed=${editProfileViewModel.user?.fullName ?? 'unknown'}',
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }

  Widget _buildWallpaperForm() {
    return SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Ảnh bìa',
                      style: Theme.of(context).textTheme.bodyLarge
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18,),
                    label: const Text('Thay đổi'),
                    style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(Theme.of(context).textTheme.labelMedium),
                        padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(5, 0, 0, 0))
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 180,
                child: Image.network(
                  'https://ispe.org/sites/default/files/styles/hero_banner_large/public/banner-images/volunteer-page-hero-1900x600.png.webp?itok=JwOK6xl2',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        )
    );
  }
}
