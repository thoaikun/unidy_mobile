import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/post_service.dart';

class DashboardViewModel extends ChangeNotifier {
  final PostService _postService = GetIt.instance<PostService>();
  final CampaignService _campaignService = GetIt.instance<CampaignService>();

  int _postOffset = 0;
  int _campaignOffset = 0;
  final int LIMIT = 3;

  bool isFirstLoading = true;
  bool isLoadMoreLoading = false;
  bool error = false;
  List<dynamic> _recommendationList = [];
  List<dynamic> get recommendationList => _recommendationList;

  DashboardViewModel() {
    initData();
  }

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

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void initData() {
    setIsFirstLoading(true);
    Future.wait([
      _postService.getRecommendationPosts(skip: _postOffset, limit: LIMIT),
      _campaignService.getRecommendCampaign(skip: _campaignOffset, limit: LIMIT),
    ])
      .then((value) {
        List<Post> postList = value[0] as List<Post>;
        CampaignData campaignData = value[1] as CampaignData;

        // update cursor and offset
        _postOffset += LIMIT;
        _campaignOffset += LIMIT;

        // merge all data
        List<dynamic> recommendationList = [...postList, ...campaignData.campaigns];
        recommendationList.shuffle();
        setRecommendationList(removeDuplicate(recommendationList));
      })
      .catchError((error) {
        setError(true);
      })
      .whenComplete(() {
        setIsFirstLoading(false);
      });
  }

  void refreshData() {
    _postOffset = 0;
    _campaignOffset = 0;
    setError(false);
    initData();
  }

  void loadMoreData() {
    setIsLoadMoreLoading(true);
    Future.wait([
      _postService.getRecommendationPosts(skip: _postOffset, limit: LIMIT),
      _campaignService.getRecommendCampaign(skip: _campaignOffset, limit: LIMIT),
    ])
      .then((value) {
        List<Post> postList = value[0] as List<Post>;
        CampaignData campaignData = value[1] as CampaignData;

        // update cursor and offset
        _postOffset += LIMIT;
        _campaignOffset += LIMIT;

        // merge all data
        List<dynamic> newData = [...postList, ...campaignData.campaigns];
        newData.shuffle();
        List<dynamic> recommendationList = [..._recommendationList, ...newData];
        setRecommendationList(removeDuplicate(recommendationList));
      })
      .catchError((error) {
        error = true;
        notifyListeners();
      })
      .whenComplete(() {
        setIsLoadMoreLoading(false);
      });
  }

  void handleLikePost(Post post) {
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

  List<dynamic> removeDuplicate(List<dynamic> list) {
    List<dynamic> result = [];
    Set<String> postIdSet = {};
    Set<int> campaignIdSet = {};
    for (var item in list) {
      if (item is Post) {
        if (!postIdSet.contains(item.postId)) {
          postIdSet.add(item.postId);
          result.add(item);
        }
      }
      else {
        if (!postIdSet.contains(item.campaign.campaignId)) {
          postIdSet.add(item.campaign.campaignId);
          result.add(item);
        }
      }
    }
    return result;
  }
}