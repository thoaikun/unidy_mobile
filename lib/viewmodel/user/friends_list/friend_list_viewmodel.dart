import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';


class FriendListViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  bool isFirstLoading = true;
  bool isLoading = false;
  final int LIMIT = 10;
  String cursor = '0';

  List<Friend> _friendList = [];
  List<Friend> get friendList => _friendList;

  void setFriendList(List<Friend> value) {
    _friendList = value;
    notifyListeners();
  }

  void setIsFirstLoading(bool value) {
    isFirstLoading = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void initData() async {
    try {
      List<Friend> friendListResponse = await _userService.getFriends({
        'limit': LIMIT.toString(),
        'cursor': cursor
      });
      // if (friendListResponse.isNotEmpty) {
      //   Friend lastFriend = friendListResponse[friendListResponse.length - 1];
      //   cursor = lastFriend.createDate;
      // }
      setFriendList(friendListResponse);
    }
    catch (error) {
      print(error);
    }
    finally {
      setIsFirstLoading(false);
    }
  }

  void loadMore() async {
    setIsLoading(true);
    try {
      List<Friend> friendListResponse = await _userService.getFriends({
        'limit': LIMIT.toString(),
        'cursor': cursor
      });
      // if (friendListResponse.isNotEmpty) {
      //   Friend lastFriend = friendListResponse[friendListResponse.length - 1];
      //   cursor = lastFriend.createDate;
      // }
      setFriendList([..._friendList , ...friendListResponse]);
    }
    catch (error) {
      print(error);
    }
    finally  {
      setIsLoading(true);
    }
  }

  void refreshData() async {
    try {
      cursor = '0';
      List<Friend> friendListResponse = await _userService.getFriends({
        'limit': LIMIT.toString(),
        'cursor': cursor
      });
      // if (friendListResponse.isNotEmpty) {
      //   Friend lastFriend = friendListResponse[friendListResponse.length - 1];
      //   cursor = lastFriend.createDate;
      // }
      setFriendList(friendListResponse);
    }
    catch (error) {
      print(error);
    }
  }

  Future<bool> unfriend(int? userId) async {
    if (userId == null) return false;

    try {
      await _userService.unfriend(userId);
      _friendList.removeWhere((friend) => friend.userId == userId);
      setFriendList(_friendList);
      return true;
    }
    catch (error) {
      return false;
    }
  }
}