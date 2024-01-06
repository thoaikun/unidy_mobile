import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/user_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final PostService postService = GetIt.instance<PostService>();

  String? _lastPostOffset;
  bool loading = true;
  bool isLoadMoreLoading = true;
  User _user = User(userId: 0);
  List<Post> _postList = [];

  User get user => _user;
  List<Post> get postList => _postList;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setIsLoadMoreLoading(bool value) {
    isLoadMoreLoading = value;
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

  void getUserProfile() {
    userService.whoAmI()
      .then((user) {
        setUser(user);
      })
      .catchError((error) {
        print(error);
      })
      .whenComplete(() => setLoading(false));
  }

  void getMyOwnPost() {
    postService.getUserPosts(_lastPostOffset)
      .then((postList) {
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        setPostList(postList);
      })
      .catchError((error) {
        print(error);
      })
      .whenComplete(() => setLoading(false));
  }

  void loadMorePosts() {
    setIsLoadMoreLoading(true);
    postService.getUserPosts(_lastPostOffset)
      .then((postList) {
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        setPostList(postList);
      })
        .whenComplete(() {
          setIsLoadMoreLoading(false);
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}