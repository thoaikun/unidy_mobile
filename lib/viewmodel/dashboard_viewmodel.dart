import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/utils/index.dart';

class DashboardViewModel extends ChangeNotifier {
  PostService postService = GetIt.instance<PostService>();
  AppPreferences appPreferences = GetIt.instance<AppPreferences>();

  String? _lastPostOffset;
  bool isFirstLoading = true;
  bool isLoadMoreLoading = false;
  List<Post> _postList = [];

  List<Post> get postList => _postList;

  void setPostList(List<Post> value) {
    _postList = _postList + value;
    notifyListeners();
  }

  void setIsFirstLoading(bool value) {
    isFirstLoading = value;
    notifyListeners();
  }

  void setIsLoadMoreLoading(bool value) {
    isLoadMoreLoading = value;
    notifyListeners();
  }

  void getPosts() {
    postService.getRecommendationPosts(_lastPostOffset)
      .then((postList) {
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        setPostList(postList);
      })
      .whenComplete(() {
        setIsFirstLoading(false);
        setIsLoadMoreLoading(false);
      });
  }

  void handleLikePost(Post post) {
    print('like post');
    if (post.isLiked == true) {
      post.isLiked = false;
      post.likeCount = post.likeCount - 1;
      notifyListeners();
      postService.unlike(post.postId);
    }
    else {
      post.isLiked = true;
      post.likeCount = post.likeCount + 1;
      notifyListeners();
      postService.like(post.postId);
    }
  }
}