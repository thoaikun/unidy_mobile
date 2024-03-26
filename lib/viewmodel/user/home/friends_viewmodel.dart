import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class FriendsViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  List<FriendRequest> _requestList = [];
  List<Friend> _friendList = [];
  List<FriendSuggestion> _recommendationList = [];
  bool isLoading = true;

  List<FriendRequest> get requestList => _requestList;
  List<Friend> get friendList => _friendList;
  List<FriendSuggestion> get recommendationList => _recommendationList;

  FriendsViewModel() {
    initData();
  }

  void setRequestList(List<FriendRequest> value) {
    _requestList = value;
    notifyListeners();
  }

  void setFriendList(List<Friend> value) {
    _friendList = value;
    notifyListeners();
  }

  void setRecommendationList(List<FriendSuggestion> value) {
    _recommendationList = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void initData() async {
    isLoading = true;
    try {
      var values = await Future.wait([
        _userService.getFriendRequests(),
        _userService.getFriends(),
        _userService.getRecommendations()
      ]);

      setRequestList(values[0] as List<FriendRequest>);
      setFriendList(values[1] as List<Friend>);
      setRecommendationList(values[2] as List<FriendSuggestion>);
      setLoading(false);
    }
    catch (error) {
      print(error);
    }
  }

  Future<bool> acceptRequest(FriendRequest? friendRequest) async {
    if (friendRequest == null) return false;

    try {
      await _userService.acceptFriendRequest(friendRequest.userRequest.userId);
      List<FriendRequest> result = _requestList.where((element) => element.userRequest.userId != friendRequest.userRequest.userId).toList();
      setRequestList(result);
      return true;
    }
    catch (error) {
      return false;
    }
  }

  Future<bool> declineRequest(FriendRequest? friendRequest) async {
    if (friendRequest == null) return false;

    try {
      await _userService.declineFriendRequest(friendRequest.userRequest.userId);
      List<FriendRequest> result = _requestList.where((element) => element.userRequest.userId != friendRequest.userRequest.userId).toList();
      setRequestList(result);
      return true;
    }
    catch (error) {
      return false;
    }
  }

  Future<bool> sendFriendRequest(int? userId) async {
    if (userId == null) return false;

    try {
      await _userService.sendFriendRequest(userId);
      return true;
    }
    catch (error) {
      return false;
    }
  }

  Future<bool> unfriend(int? userId) async {
    if (userId == null) return false;

    try {
      await _userService.unfriend(userId);
      _friendList.removeWhere((element) => element.userId != userId);
      setFriendList(_friendList);
      return true;
    }
    catch (error) {
      return false;
    }
  }
}