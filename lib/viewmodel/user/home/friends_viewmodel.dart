import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class FriendsViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  List<FriendRequest> _requestList = [];
  List<FriendRequest> _friendList = [];
  List<FriendSuggestion> _recommendationList = [];
  bool isLoading = true;

  List<FriendRequest> get requestList => _requestList;
  List<FriendRequest> get friendList => _friendList;
  List<FriendSuggestion> get recommendationList => _recommendationList;

  void setRequestList(List<FriendRequest> value) {
    _requestList = value;
    notifyListeners();
  }

  void setFriendList(List<FriendRequest> value) {
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
    try {
        List<FriendRequest> friendRequestResponse = await _userService.getFriendRequests();
        // List<Friend> friendResponse = await _userService.getFriends();
        List<FriendSuggestion> recommendationResponse = await _userService.getRecommendations({
          'limit': '4',
          'skip': '0',
          'rangeEnd': '4'
        });

        setRequestList(friendRequestResponse);
        // setFriendList(friendResponse);
        setRecommendationList(recommendationResponse);
        setLoading(false);
    }
    catch (error) {
      print(error);
    }
  }

  Future<bool> acceptRequest(FriendRequest? friendRequest) async {
    if (friendRequest == null) return false;

    try {
      await _userService.acceptFriendRequest(friendRequest.userId);
      List<FriendRequest> result = _requestList.where((element) => element.userId != friendRequest.userId).toList();
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
      await _userService.declineFriendRequest(friendRequest.userId);
      List<FriendRequest> result = _requestList.where((element) => element.userId != friendRequest.userId).toList();
      setRequestList(result);
      return true;
    }
    catch (error) {
      return false;
    }
  }

  void getRecommendation(Map<String, String> payload) async {
    try {
      List<FriendSuggestion> recommendationResponse = await _userService.getRecommendations(payload);
      setRecommendationList(recommendationResponse);
    }
    catch (error) {
      print(error);
    }
  }
}