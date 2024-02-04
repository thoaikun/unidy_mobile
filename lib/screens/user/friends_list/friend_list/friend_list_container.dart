import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/user/friends_list/friend_list/friend_list_screen.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/friend_list_viewmodel.dart';

class FriendListContainer extends StatefulWidget {
  const FriendListContainer({super.key});

  @override
  State<FriendListContainer> createState() => _FriendListContainerState();
}

class _FriendListContainerState extends State<FriendListContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FriendListViewModel(),
      child: const FriendListScreen(),
    );
  }
}
