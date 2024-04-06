import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/services/organization_service.dart';

class OrganizationCampaignHistoryViewModel extends ChangeNotifier {
  final OrganizationService _organizationService = GetIt.instance<OrganizationService>();

  final int _limit = 5;
  int _page = 0;
  bool isFirstLoading = true;
  bool isLoading = false;
  bool error = false;

  List<Campaign> _campaigns = [];
  List<Campaign> get campaigns => _campaigns;

  OrganizationCampaignHistoryViewModel() {
    initData();
  }

  void setFirstLoading(bool value) {
    isFirstLoading = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setCampaigns(List<Campaign> value) {
    _campaigns = [..._campaigns, ...value];
    _page ++;
    notifyListeners();
  }

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void initData() async {
    try {
      setFirstLoading(true);
      List<Campaign> response = await _organizationService.getOrganizationCampaigns(pageSize: _limit, pageNumber: _page);
      setCampaigns(response);
    }
    catch (e) {
      setError(true);
    }
    finally {
      setFirstLoading(false);
    }
  }

  void loadMore() async {
    try {
      setLoading(true);
      List<Campaign> response = await _organizationService.getOrganizationCampaigns(pageSize: _limit, pageNumber: _page);
      setCampaigns(response);
    }
    catch (e) {
      setError(true);
    }
    finally {
      setLoading(false);
    }
  }

  void refresh() async {
    try {
      setFirstLoading(true);
      _page = 0;
      List<Campaign> response = await _organizationService.getOrganizationCampaigns(pageSize: _limit, pageNumber: _page);
      setCampaigns(response);
    }
    catch (e) {
      setError(true);
    }
    finally {
      setFirstLoading(false);
    }
  }
}