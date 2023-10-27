import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: false,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) => const PostCard(),
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        itemCount: 4
      ),
    );
  }
}
