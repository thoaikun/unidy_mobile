import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/campaign_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/utils/index.dart';

class DashboardViewModel extends ChangeNotifier {
  final PostService _postService = GetIt.instance<PostService>();
  final CampaignService _campaignService = GetIt.instance<CampaignService>();
  final AppPreferences _appPreferences = GetIt.instance<AppPreferences>();

  String? _lastPostOffset;
  bool isFirstLoading = true;
  bool isLoadMoreLoading = false;
  List<dynamic> _recommendationList = [];

  List<dynamic> get recommendationList => _recommendationList;

  void setRecommendationList(List<dynamic> value) {
    _recommendationList = value;
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

  void initData() {
    Future.wait([
      _postService.getRecommendationPosts(_lastPostOffset),
      _campaignService.getRecommendCampaign()
    ])
      .then((value) {
        List<Post> postList = value[0] as List<Post>;
        List<Campaign> campaignList = value[1] as List<Campaign>;
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        List<dynamic> recommendationList = [...postList, ...campaignList];
        recommendationList.shuffle();
        setRecommendationList(recommendationList);
      })
      .whenComplete(() {
        setIsFirstLoading(false);
      });
  }

  void refreshData() {
    _lastPostOffset = null;
    initData();
  }

  void getPosts() {
    _postService.getRecommendationPosts(_lastPostOffset)
      .then((postList) {
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        setRecommendationList([..._recommendationList, ...postList]);
      })
      .whenComplete(() {
        setIsLoadMoreLoading(false);
      });
  }

  void getCampaigns() {
    _campaignService.getRecommendCampaign()
      .then((campaignList) {
        setRecommendationList(campaignList);
      })
      .whenComplete(() {
        setIsLoadMoreLoading(false);
      });
  }

  void handleLikePost(Post post) {
    print('like post');
    if (post.isLiked == true) {
      post.isLiked = false;
      post.likeCount = post.likeCount - 1;
      notifyListeners();
      _postService.unlike(post.postId);
    }
    else {
      post.isLiked = true;
      post.likeCount = post.likeCount + 1;
      notifyListeners();
      _postService.like(post.postId);
    }
  }
}