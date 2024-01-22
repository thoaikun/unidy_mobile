import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/request_friend_list_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';

class RequestFriendListScreen extends StatefulWidget {
  const RequestFriendListScreen({super.key});

  @override
  State<RequestFriendListScreen> createState() => _RequestFriendListScreenState();
}

class _RequestFriendListScreenState extends State<RequestFriendListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<RequestFriendListViewModel>(context, listen: false).initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<RequestFriendListViewModel>(context, listen: false).loadMore();
      }
    });
  }

  SliverFillRemaining _buildList() {
    RequestFriendListViewModel requestFriendListViewModel = Provider.of<RequestFriendListViewModel>(context, listen: true);
    List<FriendRequest> friendRequests = requestFriendListViewModel.friendRequests;

    if (friendRequests.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Empty(description: 'Không có lời mời kết bạn nào')
        ),
      );
    }

    return SliverFillRemaining(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index < friendRequests.length) {
            return RequestFriendCard(
              friendRequest: friendRequests[index],
              onAccept: requestFriendListViewModel.acceptFriendRequest,
              onDecline: requestFriendListViewModel.declineFriendRequest,
            );
          }
          else if (index == friendRequests.length && context.watch<RequestFriendListViewModel>().isLoading) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5,),
        itemCount: friendRequests.length + 1
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstLoading = Provider.of<RequestFriendListViewModel>(context, listen: true).isFirstLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lời mời kết bạn'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            !isFirstLoading ? _buildList() : const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}
