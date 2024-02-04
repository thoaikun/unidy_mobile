import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/user/friends_list/request_friend_list/request_friend_list_screen.dart';
import 'package:unidy_mobile/viewmodel/user/friends_list/request_friend_list_viewmodel.dart';

class RequestFriendListContainer extends StatefulWidget {
  const RequestFriendListContainer({super.key});

  @override
  State<RequestFriendListContainer> createState() => _RequestFriendListContainerState();
}

class _RequestFriendListContainerState extends State<RequestFriendListContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestFriendListViewModel(),
      child: const RequestFriendListScreen(),
    );
  }
}
