import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class RequestFriendListViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  bool isFirstLoading = true;
  bool isLoading = false;
  bool error = false;
  final int LIMIT = 10;

  List<FriendRequest> _friendRequests = [];
  List<FriendRequest> get friendRequests => _friendRequests;

  RequestFriendListViewModel() {
    initData();
  }

  void setFriendRequests(List<FriendRequest> value) {
    _friendRequests = value;
    notifyListeners();
  }

  void setFirstLoading(bool value) {
    isFirstLoading = value;
    notifyListeners();
  }

  void setLoading(bool value) {
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
      List<FriendRequest> friendRequestResponse = await _userService.getFriendRequests(
        limit: LIMIT,
        skip: _friendRequests.length
      );
      setFriendRequests(friendRequestResponse);
      setFirstLoading(false);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setFirstLoading(false);
    }
  }
  
  void loadMore() async {
    setLoading(true);
    setError(false);
    try {
      List<FriendRequest> friendRequestResponse = await _userService.getFriendRequests(
        limit: LIMIT,
        skip: _friendRequests.length
      );
      setFriendRequests([...friendRequests, ...friendRequestResponse]);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setLoading(false);
    }
  }

  void refreshData() async {
    setFirstLoading(true);
    setError(false);
    try {
      _friendRequests = [];
      List<FriendRequest> friendRequestResponse = await _userService.getFriendRequests(
        limit: LIMIT,
        skip: _friendRequests.length
      );
      setFriendRequests(friendRequestResponse);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setFirstLoading(false);
    }
  }

  Future<bool> acceptFriendRequest(FriendRequest? friendRequest) async {
    if (friendRequest == null) return false;

    try {
      await _userService.acceptFriendRequest(friendRequest.userRequest.userId);
      setFriendRequests(friendRequests.where((element) => element.userRequest.userId != friendRequest.userRequest.userId).toList());
      return true;
    }
    catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> declineFriendRequest(FriendRequest? friendRequest) async {
    if (friendRequest == null) return false;

    try {
      await _userService.declineFriendRequest(friendRequest.userRequest.userId);
      setFriendRequests(friendRequests.where((element) => element.userRequest.userId != friendRequest.userRequest.userId).toList());
      return true;
    }
    catch (error) {
      print(error);
      return false;
    }
  }
}