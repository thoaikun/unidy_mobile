import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/post_service.dart';

class DashboardViewModel extends ChangeNotifier {
  final PostService _postService = GetIt.instance<PostService>();
  final CampaignService _campaignService = GetIt.instance<CampaignService>();

  String? _lastPostOffset;
  int _lastCampaignFromRecommendationServiceOffset = 0;
  String? _lastCampaignFromNeo4JOffset;
  final int LIMIT = 10;

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
      _campaignService.getRecommendCampaign(offset: _lastCampaignFromRecommendationServiceOffset, cursor: _lastCampaignFromNeo4JOffset),
    ])
      .then((value) {
        List<Post> postList = value[0] as List<Post>;
        CampaignData campaignData = value[1] as CampaignData;

        // update cursor and offset
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        _lastCampaignFromRecommendationServiceOffset = campaignData.nextOffset;
        _lastCampaignFromNeo4JOffset = campaignData.nextCursor;

        // merge all data
        List<dynamic> recommendationList = [...postList, ...campaignData.campaigns];
        recommendationList.shuffle();
        setRecommendationList(removeDuplicate(recommendationList));
      })
      .whenComplete(() {
        setIsFirstLoading(false);
      });
  }

  void refreshData() {
    _lastPostOffset = null;
    initData();
  }

  void loadMoreData() {
    setIsLoadMoreLoading(true);
    Future.wait([
      _postService.getRecommendationPosts(_lastPostOffset),
      _campaignService.getRecommendCampaign(offset: _lastCampaignFromRecommendationServiceOffset, cursor: _lastCampaignFromNeo4JOffset),
    ])
      .then((value) {
        List<Post> postList = value[0] as List<Post>;
        CampaignData campaignData = value[1] as CampaignData;

        // update cursor and offset
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        _lastCampaignFromRecommendationServiceOffset = campaignData.nextOffset;
        _lastCampaignFromNeo4JOffset = campaignData.nextCursor;

        // merge all data
        List<dynamic> newData = [...postList, ...campaignData.campaigns];
        newData.shuffle();
        List<dynamic> recommendationList = [..._recommendationList, ...newData];
        setRecommendationList(removeDuplicate(recommendationList));
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
    return list.toSet().toList();
  }
}