import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/screens/user/detail_profile/volunteer_profile/volunteer_profile_container.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/request_friend_list_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/list_item.dart';
import 'package:unidy_mobile/widgets/loadmore_indicator.dart';

class RequestFriendListScreen extends StatefulWidget {
  const RequestFriendListScreen({super.key});

  @override
  State<RequestFriendListScreen> createState() => _RequestFriendListScreenState();
}

class _RequestFriendListScreenState extends State<RequestFriendListScreen> {
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
      child: ListItem<FriendRequest>(
        items: friendRequests,
        length: friendRequests.length,
        itemBuilder: (BuildContext context, int index) {
          return RequestFriendCard(
            friendRequest: friendRequests[index],
            onAccept: requestFriendListViewModel.acceptFriendRequest,
            onDecline: requestFriendListViewModel.declineFriendRequest,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: friendRequests[index].userRequest.userId))),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        isFirstLoading: requestFriendListViewModel.isFirstLoading,
        isLoading: requestFriendListViewModel.isLoading,
        error: requestFriendListViewModel.error,
        onRetry: () => requestFriendListViewModel.loadMore(),
        onLoadMore: () => requestFriendListViewModel.loadMore(),
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
