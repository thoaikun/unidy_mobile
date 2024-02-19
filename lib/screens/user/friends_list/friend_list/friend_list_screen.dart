import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/friend_list_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<FriendListViewModel>(context, listen: false).initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<FriendListViewModel>(context, listen: false).loadMore();
      }
    });
  }

  SliverFillRemaining _buildList() {
    FriendListViewModel friendListViewModel = Provider.of<FriendListViewModel>(context, listen: true);
    List<Friend> friends = friendListViewModel.friendList;

    if (friends.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
            child: Empty(description: 'Bạn chưa có bạn bè nào')
        ),
      );
    }

    return SliverFillRemaining(
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index < friends.length) {
              return FriendCard(
                friend: friends[index],
                onUnfriend: friendListViewModel.unfriend,
              );
            }
            else if (index == friends.length && context.watch<FriendListViewModel>().isLoading) {
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
          itemCount: friends.length + 1
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstLoading = Provider.of<FriendListViewModel>(context, listen: true).isFirstLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bạn bè của tôi'),
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
