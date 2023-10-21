import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const AvatarCard(
        showTime: true,
        description: 'Đã đăng một kỉ niệm',
      ),
    );
  }
}
