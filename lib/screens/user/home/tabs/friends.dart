import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/models/friend_model.dart';
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
    Provider.of<FriendsViewModel>(context, listen: false).initData();
  }

  SliverToBoxAdapter _buildRequestList() {
    List<FriendRequest> requestList = Provider.of<FriendsViewModel>(context, listen: true).requestList;
    List<Widget> requestWidgetList = [];

    if (requestList.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox(height: 0));
    }

    for (int i=0; i < requestList.length; i++) {
      FriendRequest friendRequest = requestList[i];
      requestWidgetList.add(
        RequestFriendCard(
          friendRequest: friendRequest,
          onAccept: Provider.of<FriendsViewModel>(context, listen: false).acceptRequest,
          onDecline: Provider.of<FriendsViewModel>(context, listen: false).declineRequest,
        )
      );
      if (i < requestList.length - 1) {
        requestWidgetList.add(const Divider(height: 0.5));
      }
    }

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
                  children: requestWidgetList
                )
              ],
            ),
          );
        }
      )
    );
  }

  SliverToBoxAdapter _buildSuggestionList() {
    List<FriendSuggestion> recommendationList = Provider.of<FriendsViewModel>(context, listen: true).recommendationList;
    List<Widget> recommendationWidgetList = [];

    if (recommendationList.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox(height: 25));
    }

    for (int i=0; i < recommendationList.length; i++) {
      FriendSuggestion friendSuggestion = recommendationList[i];
      recommendationWidgetList.add(
        AddFriendCard(
          friendSuggestion: friendSuggestion,
        )
      );
      if (i < recommendationList.length - 1) {
        recommendationWidgetList.add(const Divider(height: 0.5));
      }
    }

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
            Column(
              children: recommendationWidgetList
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

  Widget _buildSkeleton() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
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
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
        SliverToBoxAdapter(
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FriendsViewModel>(
      builder: (BuildContext context, FriendsViewModel friendsViewModel, Widget? child) {
        return Skeletonizer(
          enabled: friendsViewModel.isLoading,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: !friendsViewModel.isLoading ? CustomScrollView(
              slivers: [
                _buildRequestList(),
                _buildSuggestionList(),
                _buildFriendList()
              ],
            ) : _buildSkeleton(),
          ),
        );
      }
    );
  }
}
