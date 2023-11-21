import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/input/input.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa tài khoản'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_rounded, color: PrimaryColor.primary500),
            label: const Text('Lưu'),
          )
        ],
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

  Widget _buildInformationForm() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Thông tin cá nhân',
                style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(height: 10),
            const Input(
                label: 'Tên',
                prefixIcon: Icon(Icons.person_2_rounded)
            ),
            const SizedBox(height: 20),
            const Input(
              label: 'Ngày sinh',
              prefixIcon: Icon(Icons.calendar_month_rounded),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            const Input(
                label: 'Giới tính',
                prefixIcon: Icon(Icons.transgender_rounded)
            ).dropdown(context, ['Nam', 'Nữ', 'Khác'], null),
            const SizedBox(height: 20),
            const Input(
              label: 'Số điện thoại',
              numberKeyboard: true,
              prefixIcon: Icon(Icons.phone_android_rounded),
            ),
            const SizedBox(height: 20),
            const Input(
                label: 'Nghề nghiệp',
                prefixIcon: Icon(Icons.cases_rounded)
            ),
            const SizedBox(height: 20),
            const Input(
              label: 'Nơi công tác',
              prefixIcon: Icon(Icons.business),
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarForm() {
    return SliverToBoxAdapter(
      child: Container(
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
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: PrimaryColor.primary500,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: const CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
                ),
              ),
            ),
          ],
        ),
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
