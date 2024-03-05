import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class SuggestionFriendListViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  bool isFirstLoading = true;
  bool isLoading = false;
  int _skip = 0;
  int _rangeEnd = 4;

  List<FriendSuggestion> _friendSuggestionList = [];
  List<FriendSuggestion> get friendSuggestionList => _friendSuggestionList;

  void setFriendSuggestionList(List<FriendSuggestion> value) {
    _friendSuggestionList = value;
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

  void initData() async {
    _rangeEnd = 4;
    _skip = 0;
    try {
      List<FriendSuggestion> friendSuggestionResponse = await _userService.getRecommendations({
        'limit': '10',
        'skip': _skip.toString(),
        'rangeEnd': _rangeEnd.toString()
      });
      setFriendSuggestionList(friendSuggestionResponse);
      setFirstLoading(false);
      _skip += 10;
      _rangeEnd += 1;
    }
    catch (error) {
      print(error);
    }
  }

  void loadMore() async {
    setLoading(true);
    try {
      List<FriendSuggestion> friendSuggestionResponse = await _userService.getRecommendations({
        'limit': '10',
        'skip': _skip.toString(),
        'rangeEnd': _rangeEnd.toString()
      });
      setFriendSuggestionList([..._friendSuggestionList, ...friendSuggestionResponse]);
      _skip += 10;
      _rangeEnd += 1;
      setLoading(false);
    }
    catch (error) {
      print(error);
    }
  }

  void refreshData() async {
    setFirstLoading(true);
    try {
      _skip = 0;
      _rangeEnd = 4;
      List<FriendSuggestion> friendSuggestionResponse = await _userService.getRecommendations({
        'limit': '10',
        'skip': _skip.toString(),
        'rangeEnd': _rangeEnd.toString()
      });
      setFriendSuggestionList(friendSuggestionResponse);
    }
    catch (error) {
      print(error);
    }
    finally {
      setFirstLoading(false);
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
}