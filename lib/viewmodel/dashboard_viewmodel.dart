import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/services/post_service.dart';

class DashboardViewModel extends ChangeNotifier {
  PostService postService = GetIt.instance<PostService>();
  AppPreferences appPreferences = GetIt.instance<AppPreferences>();

  bool loading = true;
  List<Post> _postList = [];

  List<Post> get postList => _postList;

  void setPostList(List<Post> value) {
    _postList = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void initData() {
    postService.getRecommendationPosts()
      .then((postList) {
        setPostList(postList);
        setLoading(false);
      });
  }
}