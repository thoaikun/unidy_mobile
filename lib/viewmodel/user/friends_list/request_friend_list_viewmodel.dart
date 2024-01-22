import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/services/user_service.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class RequestFriendListViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  bool isFirstLoading = true;
  bool isLoading = false;
  final int LIMIT = 10;
  String cursor = Formatter.formatTime(DateTime.now(), 'yyyy-MM-ddTHH:mm:ss')!;

  List<FriendRequest> _friendRequests = [];
  List<FriendRequest> get friendRequests => _friendRequests;

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

  void initData() async {
    try {
      List<FriendRequest> friendRequestResponse = await _userService.getFriendRequests({
        'limit': LIMIT.toString(),
        'cursor': cursor.toString()
      });
      if (friendRequestResponse.isNotEmpty) {
        cursor = Formatter.formatTime(friendRequestResponse[friendRequestResponse.length - 1].requestAt, 'yyyy-MM-ddTHH:mm:ss').toString();
      }
      setFriendRequests(friendRequestResponse);
      setFirstLoading(false);
    }
    catch (error) {
      print(error);
    }
    finally {
      setFirstLoading(false);
    }
  }
  
  void loadMore() async {
    setLoading(true);
    try {
      List<FriendRequest> friendRequestResponse = await _userService.getFriendRequests({
        'limit': LIMIT.toString(),
        'cursor': cursor
      });
      if (friendRequestResponse.isNotEmpty) {
        cursor = Formatter.formatTime(friendRequestResponse[friendRequestResponse.length - 1].requestAt, 'yyyy-MM-ddTHH:mm:ss').toString();
      }
      setFriendRequests([...friendRequests, ...friendRequestResponse]);
    }
    catch (error) {
      print(error);
    }
    finally {
      setLoading(false);
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