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
      _campaignService.getRecommendCampaignFromRecommendService(offset: _lastCampaignFromRecommendationServiceOffset),
      _campaignService.getRecommendCampaignFromNeo4J(_lastCampaignFromNeo4JOffset)
    ])
      .then((value) {
        List<Post> postList = value[0] as List<Post>;
        List<CampaignPost> campaignListFromRecommendationService = value[1] as List<CampaignPost>;
        List<CampaignPost> campaignListFromNeo4J = value[2] as List<CampaignPost>;

        // update cursor and offset
        if (postList.isNotEmpty) {
          Post lastPost = postList[postList.length - 1];
          _lastPostOffset = lastPost.createDate;
        }
        if (campaignListFromRecommendationService.isNotEmpty) {
          _lastCampaignFromRecommendationServiceOffset += _campaignService.CAMPAIGN_LIMIT;
        }
        if (campaignListFromNeo4J.isNotEmpty) {
          CampaignPost lastCampaign = campaignListFromNeo4J[campaignListFromNeo4J.length - 1];
          _lastCampaignFromNeo4JOffset = lastCampaign.campaign.createDate;
        }

        // merge all data
        List<dynamic> recommendationList = [...postList, ...removeDuplicateCampaign([ ...campaignListFromRecommendationService, ...campaignListFromNeo4J])];
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
    Future.wait([
      _campaignService.getRecommendCampaignFromRecommendService(offset: _lastCampaignFromRecommendationServiceOffset),
      _campaignService.getRecommendCampaignFromNeo4J(_lastCampaignFromNeo4JOffset)
    ])
      .then((value) {
        List<CampaignPost> campaignList = removeDuplicateCampaign([ ...value[0], ...value[1]]);
        setRecommendationList([..._recommendationList, ...campaignList]);
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

  List<CampaignPost> removeDuplicateCampaign(List<CampaignPost> campaignList) {
    return campaignList.toSet().toList();
  }
}