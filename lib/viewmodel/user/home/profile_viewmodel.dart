import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/user_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();
  final PostService _postService = GetIt.instance<PostService>();

  final int LIMIT = 5;
  int _postOffset = 0;
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
    _postService.getUserPosts(user.userId, skip: _postOffset, limit: LIMIT)
      .then((postList) {
        _postOffset += LIMIT;
        setPostList(postList);
      })
      .catchError((error) {
        print(error);
      })
      .whenComplete(() => setLoading(false));
  }

  void loadMorePosts() {
    setIsLoadMoreLoading(true);
    _postService.getUserPosts(user.userId, skip: _postOffset, limit: LIMIT)
      .then((postList) {
        _postOffset += LIMIT;
        setPostList(postList);
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
}