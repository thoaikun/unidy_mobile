import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/friend_card/friend_card.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {

  SliverFillRemaining _buildList() {
    return SliverFillRemaining(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) => const FriendCard(),
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5,),
        itemCount: 10
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lời mời kết bạn'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            _buildList()
          ],
        ),
      ),
    );
  }
}
