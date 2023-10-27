import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  SliverToBoxAdapter _buildRequestList() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'friends/request'),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Lời mời kết bạn', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const FriendCard().request(context),
                const Divider(height: 0.5),
                const FriendCard().request(context),
                const Divider(height: 0.5),
                const FriendCard().request(context),
                const Divider(height: 0.5),
                const FriendCard().request(context),
              ],
            )
          ],
        ),
      )
    );
  }

  SliverToBoxAdapter _buildSuggestionList() {
    return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'friends/suggestion'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Có thể bạn quan tâm', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                  ],
                ),
              ),
              Column(
                children: [
                  const FriendCard().addFriend(context),
                  const Divider(height: 0.5),
                  const FriendCard().addFriend(context),
                  const Divider(height: 0.5),
                  const FriendCard().addFriend(context),
                  const Divider(height: 0.5),
                  const FriendCard().addFriend(context),
                ],
              )
            ],
          ),
        )
    );
  }

  SliverToBoxAdapter _buildFriendList() {
    return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'friends/list'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Bạn bè của bạn', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                  ],
                ),
              ),
              const Column(
                children: [
                  FriendCard(),
                  Divider(height: 0.5),
                  FriendCard(),
                  Divider(height: 0.5),
                  FriendCard(),
                  Divider(height: 0.5),
                  FriendCard(),
                ],
              )
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: CustomScrollView(
        slivers: [
          _buildRequestList(),
          _buildSuggestionList(),
          _buildFriendList()
        ],
      ),
    );
  }
}
