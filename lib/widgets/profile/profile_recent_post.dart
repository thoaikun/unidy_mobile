import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';

class ProfileRecentPost extends StatefulWidget {
  const ProfileRecentPost({super.key});

  @override
  State<ProfileRecentPost> createState() => _ProfileRecentPostState();
}

class _ProfileRecentPostState extends State<ProfileRecentPost> {
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (BuildContext context, int index) {
        return const PostCard();
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: 5,
    );
  }
}
