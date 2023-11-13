import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';

class ProfileAchievement extends StatelessWidget {
  final String trophyImage = 'assets/imgs/icon/trophy.png';
  final String greenMedalImage = 'assets/imgs/icon/green_medal.png';
  final String silverMedalImage = 'assets/imgs/icon/silver_medal.png';
  final String blueMedalImage = 'assets/imgs/icon/blue_medal.png';

  const ProfileAchievement({super.key});

  Widget _buildMedalList() {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListTile(
            title: const Text('Hiến máu nhân đạo'),
            subtitle: const Text('Tại: Đại học bách khoa'),
            leading: Image.asset(greenMedalImage),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          ),
        ),
        SizedBox(
          height: 60,
          child: ListTile(
            title: const Text('Hiến máu nhân đạo'),
            subtitle: const Text('Tại: Đại học bách khoa'),
            leading: Image.asset(silverMedalImage),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          ),
        ),
        SizedBox(
          height: 60,
          child: ListTile(
            title: const Text('Hiến máu nhân đạo'),
            subtitle: const Text('Tại: Đại học bách khoa'),
            leading: Image.asset(blueMedalImage),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Huân chương của bạn'),
            subtitle: const Text('Ông hoàng từ thiện'),
            leading: Image.asset(trophyImage),
            subtitleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: WarningColor.warning500),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          Text('Các hoạt động đã tham gia', style: Theme.of(context).textTheme.titleMedium,),
          _buildMedalList()
        ],
      ),
    );
  }
}
