import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';

class RequestFriendListScreen extends StatefulWidget {
  const RequestFriendListScreen({super.key});

  @override
  State<RequestFriendListScreen> createState() => _RequestFriendListScreenState();
}

class _RequestFriendListScreenState extends State<RequestFriendListScreen> {

  SliverFillRemaining _buildList() {
    return SliverFillRemaining(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) => const FriendCard().request(context),
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
