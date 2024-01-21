import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/user/friends_list/suggestion_friend_list/suggestion_friend_list_screen.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/suggestion_friend_list_viewmodel.dart';

class SuggestionFriendListContainer extends StatefulWidget {
  const SuggestionFriendListContainer({super.key});

  @override
  State<SuggestionFriendListContainer> createState() => _SuggestionFriendListContainerState();
}

class _SuggestionFriendListContainerState extends State<SuggestionFriendListContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SuggestionFriendListViewModel(),
      child: const SuggestionFriendListScreen(),
    );
  }
}
