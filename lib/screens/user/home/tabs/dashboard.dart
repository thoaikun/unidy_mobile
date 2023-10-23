import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/avatar/avatar_card.dart';
import 'package:unidy_mobile/widgets/post_card/post_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => const PostCard(),
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
      itemCount: 4
    );
  }
}
