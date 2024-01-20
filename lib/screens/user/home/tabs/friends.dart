import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/user/friends_list/friends_list_screen.dart';
import 'package:unidy_mobile/screens/user/friends_list/request_friends_list_screen.dart';
import 'package:unidy_mobile/screens/user/friends_list/suggestion_friend_list_screen.dart';
import 'package:unidy_mobile/viewmodel/user/home/friends_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<FriendsViewModel>(context, listen: false).initData();
  }

  SliverToBoxAdapter _buildRequestList() {
    return SliverToBoxAdapter(
      child: Consumer<FriendsViewModel>(
        builder: (BuildContext context, FriendsViewModel friendsViewModel, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestFriendListScreen())),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Lời mời kết bạn', style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 5),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    RequestFriendCard(
                      onAccept: friendsViewModel.acceptRequest,
                      onDecline: friendsViewModel.declineRequest,
                    ),
                    const Divider(height: 0.5),
                    const RequestFriendCard(),
                    const Divider(height: 0.5),
                    const RequestFriendCard(),
                    const Divider(height: 0.5),
                    const RequestFriendCard(),
                  ],
                )
              ],
            ),
          );
        }
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
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SuggestionFriendListScreen())),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Có thể bạn quan tâm', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                  ],
                ),
              ),
              const Column(
                children: [
                  AddFriendCard(),
                  Divider(height: 0.5),
                  AddFriendCard(),
                  Divider(height: 0.5),
                  AddFriendCard(),
                  Divider(height: 0.5),
                  AddFriendCard(),
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
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FriendListScreen())),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Bạn bè của bạn', style: Theme.of(context).textTheme.bodyMedium),
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
