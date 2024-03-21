import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/organization_service.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/user_service.dart';

abstract class OtherProfileViewModel extends ChangeNotifier {
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
  final OrganizationService _organizationService = GetIt.instance<OrganizationService>();
  final CampaignService _campaignService = GetIt.instance<CampaignService>();

  final int LIMIT = 5;
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
    await _organizationService.getOrganizationInfo(organizationId)
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
}

class VolunteerProfileViewModel extends OtherProfileViewModel {
  final PostService _postService = GetIt.instance<PostService>();
  final UserService _userService = GetIt.instance<UserService>();

  int volunteerId;
  bool isLoading = true;
  bool isLoadingMore = false;
  int _postOffset = 0;
  bool error = false;

  User? user;
  List<Post> posts = [];

  VolunteerProfileViewModel({required this.volunteerId}) {
    initData();
  }

  @override
  Future<void> getPosts() async {

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
    // TODO: implement loadMoreData
  }

  @override
  void refreshData() {
    _postOffset = 0;
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

}