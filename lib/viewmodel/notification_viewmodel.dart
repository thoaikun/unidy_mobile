import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/notification_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class NotificationViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  final int _limit = 5;
  int _page = 0;
  bool isFirstLoading = true;
  bool isLoadMoreLoading = false;
  bool error = false;
  List<NotificationItem> notificationItems = [];
  int totalUnseen = 0;

  NotificationViewModel() {
    initData();
  }

  void setIsFirstLoading(bool value) {
    isFirstLoading = value;
    notifyListeners();
  }

  void setIsLoadMoreLoading(bool value) {
    isLoadMoreLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void setNotificationItems(List<NotificationItem> value) {
    if (value.isEmpty) {
      return;
    }
    _page ++;
    notificationItems = notificationItems + value;
    notifyListeners();
  }

  void setTotalUnseen(int value) {
    totalUnseen = value;
    notifyListeners();
  }

  void initData() async {
    try {
      setIsFirstLoading(true);
      List<NotificationItem> notifications = await _userService.getNotifications(pageNumber: _page, pageSize: _limit);
      int unseen = await _userService.getTotalUnseenNotification();
      notificationItems = notifications;
      totalUnseen = unseen;
      notifyListeners();
    }
    catch (e) {
      setError(true);
    }
    finally {
      setIsFirstLoading(false);
    }
  }

  void loadMore() async {
    try {
      setIsLoadMoreLoading(true);
      List<NotificationItem> notifications = await _userService.getNotifications(pageNumber: _page, pageSize: _limit);
      setNotificationItems(notifications);
    }
    catch (e) {
      setError(true);
    }
    finally {
      setIsLoadMoreLoading(false);
    }
  }

  void onRefresh() {
    _page = 0;
    initData();
  }

  void onMarkAsRead() async {
    await _userService.markAllNotificationAsRead();
    for (var item in notificationItems) {
      item.seenTime = DateTime.now();
    }
    totalUnseen = 0;
    notifyListeners();
  }

  void onMarkAsReadItem(int notificationId) async {
    await _userService.markNotificationAsRead(notificationId);
    totalUnseen --;
    notifyListeners();
  }
}