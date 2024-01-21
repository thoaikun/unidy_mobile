import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/suggestion_friend_list_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';

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
    suggestionFriendListViewModel.initData();
  }

  SliverFillRemaining _buildList() {
    SuggestionFriendListViewModel suggestionFriendListViewModel = Provider.of<SuggestionFriendListViewModel>(context, listen: true);
    List<FriendSuggestion> friendSuggestionList = suggestionFriendListViewModel.friendSuggestionList;

    return SliverFillRemaining(
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index < friendSuggestionList.length) {
              return AddFriendCard(
                friendSuggestion: friendSuggestionList[index],
                onSendFriendRequest: suggestionFriendListViewModel.sendFriendRequest,
              );
            }
            else if (index == friendSuggestionList.length && context.watch<SuggestionFriendListViewModel>().isLoading) {
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
          itemCount: friendSuggestionList.length + 1
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
