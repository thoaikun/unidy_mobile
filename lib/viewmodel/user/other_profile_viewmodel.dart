import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/firebase_service.dart';
import 'package:unidy_mobile/services/organization_service.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/user_service.dart';

abstract class OtherProfileViewModel extends ChangeNotifier {
  final int LIMIT = 5;
  void initData();
  void refreshData();
  void loadMoreData();
  Future<void> getProfile();
  Future<void> getPosts();
  void setLoading(bool value);
  void setLoadingMore(bool value);
  void setError(bool value);
}

class OrganizationProfileViewModel extends OtherProfileViewModel {
  final CampaignService _campaignService = GetIt.instance<CampaignService>();
  final UserService _userService = GetIt.instance<UserService>();
  final FirebaseService _firebaseService = GetIt.instance<FirebaseService>();

  int organizationId;
  bool isLoading = true;
  bool isLoadingMore = false;
  int _postOffset = 0;
  bool error = false;

  Organization? organization;
  List<CampaignPost> campaigns = [];

  OrganizationProfileViewModel({required this.organizationId}) {
    initData();
  }

  @override
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void setLoadingMore(bool value) {
    isLoadingMore = value;
    notifyListeners();
  }

  @override
  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  @override
  Future<void> getPosts() async {
    await _campaignService.getOrganizationCampaignPosts(organizationId, limit: LIMIT)
      .then((value) {
        campaigns = value.campaigns;
        _postOffset += LIMIT;
        notifyListeners();
      })
      .catchError((error) {
        throw error;
      });
  }

  @override
  Future<void> getProfile() async {
    await _userService.getOrganizationInfo(organizationId)
      .then((value) {
        organization = value;
        notifyListeners();
      })
      .catchError((error) {
        throw error;
      });
  }

  @override
  void initData() async {
    setLoading(true);
    try {
      await Future.wait([
        getProfile(),
        getPosts(),
      ]);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setLoading(false);
    }
  }

  @override
  void loadMoreData() {
    setLoadingMore(true);
    _campaignService.getOrganizationCampaignPosts(organizationId, skip: _postOffset, limit: LIMIT)
      .then((value) {
        campaigns.addAll(value.campaigns);
        _postOffset += LIMIT;
        notifyListeners();
      })
      .catchError((error) {
        setError(true);
      })
      .whenComplete(() {
        setLoadingMore(false);
      });
  }

  @override
  void refreshData() {
    _postOffset = 0;
    initData();
  }

  void onFollow() async {
    try {
      String topic = await _userService.followOrganization(organizationId);
      _firebaseService.subscribeToTopic(topic);
      organization!.isFollow = true;
      notifyListeners();
    }
    catch (error) {
      rethrow;
    }
  }

  void handleLikeCampaign(CampaignPost campaign) {
    if (campaign.isLiked == true) {
      campaign.isLiked = false;
      notifyListeners();
      _campaignService.unlike(campaign.campaign.campaignId);
    }
    else {
      campaign.isLiked = true;
      notifyListeners();
      _campaignService.like(campaign.campaign.campaignId);
    }
  }
}

class VolunteerProfileViewModel extends OtherProfileViewModel {
  final PostService _postService = GetIt.instance<PostService>();
  final UserService _userService = GetIt.instance<UserService>();

  int volunteerId;
  bool isLoading = true;
  bool isLoadingMore = false;
  bool error = false;

  User? user;
  List<Post> posts = [];

  VolunteerProfileViewModel({required this.volunteerId}) {
    initData();
  }

  @override
  Future<void> getPosts() async {
    _postService.getUserPosts(volunteerId, skip: posts.length, limit: LIMIT)
      .then((value) {
        posts = value;
        notifyListeners();
      })
      .catchError((error) {
        setError(true);
      });
  }

  @override
  Future<void> getProfile() async {
    await _userService.getOtherUserProfile(volunteerId)
      .then((value) {
        user = value;
        notifyListeners();
      })
      .catchError((error) {
        throw error;
      });
  }

  @override
  void initData() {
    setLoading(true);
    try {
      Future.wait([
        getProfile(),
        getPosts(),
      ]);
    }
    catch (error) {
      setError(true);
    }
    finally {
      setLoading(false);
    }
  }

  @override
  void loadMoreData() {
    setLoadingMore(true);
    _postService.getUserPosts(volunteerId, skip: posts.length, limit: LIMIT)
      .then((value) {
        posts.addAll(value);
        notifyListeners();
      })
      .catchError((error) {
        setError(true);
      })
      .whenComplete(() {
        setLoadingMore(false);
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

  @override
  void refreshData() {
    posts = [];
    initData();
  }

  @override
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void setLoadingMore(bool value) {
    isLoadingMore = value;
    notifyListeners();
  }

  @override
  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void onSendFriendRequest() async {
    try {
      await _userService.sendFriendRequest(volunteerId);
      user?.isRequesting = true;
      notifyListeners();
    }
    catch (error) {
      rethrow;
    }
  }

  void onAcceptFriendRequest() async {
    try {
      await _userService.acceptFriendRequest(volunteerId);
      user?.isFriend = true;
      user?.isRequested = false;
      notifyListeners();
    }
    catch (error) {
      rethrow;
    }
  }
}