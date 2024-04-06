import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class SuggestionFriendListViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  bool isFirstLoading = true;
  bool isLoading = false;
  bool error = false;
  int _rangeEnd = 4;

  List<FriendSuggestion> _friendSuggestionList = [];
  List<FriendSuggestion> get friendSuggestionList => _friendSuggestionList;

  SuggestionFriendListViewModel() {
    initData();
  }

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

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void initData() async {
    _rangeEnd = 4;
    try {
      setFirstLoading(true);
      setError(false);
      List<FriendSuggestion> friendSuggestionResponse = await _userService.getRecommendations(
        limit: 10,
        skip: _friendSuggestionList.length,
        rangeEnd: _rangeEnd
      );
      setFriendSuggestionList(friendSuggestionResponse);
      _rangeEnd += 1;
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
      List<FriendSuggestion> friendSuggestionResponse = await _userService.getRecommendations(
        limit: 10,
        skip: _friendSuggestionList.length,
        rangeEnd: _rangeEnd
      );
      setFriendSuggestionList([..._friendSuggestionList, ...friendSuggestionResponse]);
      _rangeEnd += 1;
    }
    catch (error) {
      setError(true);
    }
    finally {
      setLoading(false);
    }
  }

  void refreshData() async {
    try {
      setFirstLoading(true);
      setError(false);
      _friendSuggestionList.clear();
      _rangeEnd = 4;
      List<FriendSuggestion> friendSuggestionResponse = await _userService.getRecommendations(
        limit: 10,
        skip: _friendSuggestionList.length,
        rangeEnd: _rangeEnd
      );
      setFriendSuggestionList(friendSuggestionResponse);
    }
    catch (error) {
      setError(true);
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