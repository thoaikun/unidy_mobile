import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/screens/user/detail_profile/volunteer_profile/volunteer_profile_container.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/suggestion_friend_list_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/list_item.dart';
import 'package:unidy_mobile/widgets/loadmore_indicator.dart';

class SuggestionFriendListScreen extends StatefulWidget {
  const SuggestionFriendListScreen({
    super.key
  });

  @override
  State<SuggestionFriendListScreen> createState() => _SuggestionFriendListScreenState();
}

class _SuggestionFriendListScreenState extends State<SuggestionFriendListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SuggestionFriendListViewModel suggestionFriendListViewModel = Provider.of<SuggestionFriendListViewModel>(context, listen: false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        suggestionFriendListViewModel.loadMore();
      }
    });
  }

  SliverFillRemaining _buildList() {
    SuggestionFriendListViewModel suggestionFriendListViewModel = Provider.of<SuggestionFriendListViewModel>(context, listen: true);
    List<FriendSuggestion> friendSuggestionList = suggestionFriendListViewModel.friendSuggestionList;

    if (friendSuggestionList.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Empty(description: 'Không có người nào được đề xuất')
        ),
      );
    }

    return SliverFillRemaining(
      child: ListItem<FriendSuggestion>(
        items: friendSuggestionList,
        length: friendSuggestionList.length,
        itemBuilder: (BuildContext context, int index) {
          return AddFriendCard(
            friendSuggestion: friendSuggestionList[index],
            onSendFriendRequest: suggestionFriendListViewModel.sendFriendRequest,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: friendSuggestionList[index].fiendSuggest.userId))),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5,),
        isFirstLoading: suggestionFriendListViewModel.isFirstLoading,
        isLoading: suggestionFriendListViewModel.isLoading,
        error: suggestionFriendListViewModel.error,
        onRetry: suggestionFriendListViewModel.loadMore,
        onLoadMore: suggestionFriendListViewModel.loadMore,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstLoading = Provider.of<SuggestionFriendListViewModel>(context, listen: true).isFirstLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Có thể bạn quan tâm'),
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
