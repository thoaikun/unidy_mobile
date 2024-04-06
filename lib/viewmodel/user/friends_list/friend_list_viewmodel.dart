import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';


class FriendListViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  bool isFirstLoading = true;
  bool isLoading = false;
  bool error = false;
  final int LIMIT = 10;

  List<Friend> _friendList = [];
  List<Friend> get friendList => _friendList;

  FriendListViewModel() {
    initData();
  }

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

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void initData() async {
    try {
      setError(false);
      setIsFirstLoading(true);
      List<Friend> friendListResponse = await _userService.getFriends(
        limit: LIMIT,
        skip: _friendList.length
      );
      setFriendList(friendListResponse);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setIsFirstLoading(false);
    }
  }

  void loadMore() async {
    try {
      setError(false);
      setIsLoading(true);
      List<Friend> friendListResponse = await _userService.getFriends(
        limit: LIMIT,
        skip: _friendList.length
      );
      setFriendList([..._friendList , ...friendListResponse]);
    }
    catch (error) {
      setError(true);
    }
    finally  {
      setIsLoading(true);
    }
  }

  void refreshData() async {
    try {
      _friendList.clear();
      setError(false);
      setIsFirstLoading(true);
      List<Friend> friendListResponse = await _userService.getFriends(
        limit: LIMIT,
        skip: _friendList.length
      );
      setFriendList(friendListResponse);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setIsFirstLoading(false);
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