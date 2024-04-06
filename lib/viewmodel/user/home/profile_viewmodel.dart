import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/models/local_data_model.dart';
import 'package:unidy_mobile/models/notification_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/user_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();
  final PostService _postService = GetIt.instance<PostService>();
  final AppPreferences _appPreferences = GetIt.instance<AppPreferences>();
  BuildContext context;

  final int LIMIT = 5;
  bool loading = true;
  bool isLoadMoreLoading = true;
  bool error = false;
  User _user = User(userId: 0);
  List<Post> _postList = [];

  User get user => _user;
  List<Post> get postList => _postList;

  ProfileViewModel({required this.context}) {
    User user = context.read<ProfileCubit>().state;
    if (user.fullName == null) {
      getUserProfile();
      context.read<ProfileCubit>().setProfile(user);
    }
  }

  void setLoading(bool value) {
    loading = value;
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

  void setUser(User value) {
    _user = value;
    notifyListeners();
  }

  void setPostList(List<Post> value) {
    _postList = _postList + value;
    notifyListeners();
  }

  void cleanPostList() {
    _postList = [];
    notifyListeners();
  }

  void getUserProfile() {
    _userService.whoAmI()
      .then((user) {
        setUser(user);
      })
      .catchError((error) {
        print(error);
      })
      .whenComplete(() => setLoading(false));
  }

  void getMyOwnPost() {
    setError(false);
    _postService.getUserPosts(user.userId, skip: _postList.length, limit: LIMIT)
      .then((postList) {
        setPostList(postList);
      })
      .catchError((error) {
        setError(true);
      })
      .whenComplete(() => setLoading(false));
  }

  void loadMorePosts() {
    setIsLoadMoreLoading(true);
    setError(false);
    _postService.getUserPosts(user.userId, skip: _postList.length, limit: LIMIT)
      .then((postList) {
        setPostList(postList);
      })
      .catchError((error) {
        setError(true);
      })
      .whenComplete(() {
        setIsLoadMoreLoading(false);
      });
  }

  void handleLikePost(Post post) {
    if (post.isLiked == true) {
      post.isLiked = false;
      notifyListeners();
      _postService.unlike(post.postId);
    }
    else {
      post.isLiked = true;
      notifyListeners();
      _postService.like(post.postId);
    }
  }

  Future<List<NotificationItem>> getNotifications() async {
    return await _userService.getNotifications();
  }

  Future<int> getTotalUnseen() async {
    return await _userService.getTotalUnseenNotification();
  }
}