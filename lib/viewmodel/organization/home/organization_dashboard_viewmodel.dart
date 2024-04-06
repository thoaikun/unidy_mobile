import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/organization_service.dart';

enum EDonationSort { newest, highest }

class OrganizationDashboardViewModel extends ChangeNotifier {
  final OrganizationService _organizationService = GetIt.instance<OrganizationService>();

  final int _limit = 5;
  EDonationSort _sort = EDonationSort.newest;
  bool isNewestLoading = true;
  bool isTopLoading = true;
  bool isCampaignLoading = true;
  List<DonationHistory> _topDonations = [];
  List<DonationHistory> _newestDonations = [];
  List<Campaign> _newestCampaign = [];

  List<DonationHistory> get topDonations => _topDonations;
  List<DonationHistory> get newestDonations => _newestDonations;
  List<Campaign> get newestCampaign => _newestCampaign;

  OrganizationDashboardViewModel() {
    loadDonations();
    loadCampaigns();
  }

  void setDonationHistoryLoading(bool isLoading) {
    if (_sort == EDonationSort.newest) {
      isNewestLoading = isLoading;
    } else if (_sort == EDonationSort.highest) {
      isTopLoading = isLoading;
    }
    notifyListeners();
  }

  void setCampaignLoading(bool isLoading) {
    isCampaignLoading = isLoading;
    notifyListeners();
  }

  void changeTab(int index) {
    switch (index) {
      case 0:
        _sort = EDonationSort.newest;
        break;
      case 1:
        _sort = EDonationSort.highest;
        break;
    }
    loadDonations();
  }

  void setDonations(List<DonationHistory> donations) {
    if (_sort == EDonationSort.newest) {
      _newestDonations = donations;
    } else if (_sort == EDonationSort.highest) {
      _topDonations = donations;
    }
    notifyListeners();
  }

  void setCampaigns(List<Campaign> campaigns) {
    _newestCampaign = campaigns;
    notifyListeners();
  }

  void loadDonations() async {
    if (_sort == EDonationSort.newest && _newestDonations.isNotEmpty) return;
    else if (_sort == EDonationSort.highest && _topDonations.isNotEmpty) return;
    setDonationHistoryLoading(true);
    try {
      final donations = await _organizationService.getDonations(pageSize: _limit, sort: _sort == EDonationSort.newest ? 'newest' : 'top');
      setDonations(donations);
    }
    catch (error) {
      rethrow;
    }
    finally {
      setDonationHistoryLoading(false);
    }
  }

  void loadCampaigns() async {
    if (_newestCampaign.isNotEmpty) return;
    setCampaignLoading(true);
    try {
      List<Campaign> campaigns = await _organizationService.getOrganizationCampaigns(pageSize: _limit);
      setCampaigns(campaigns);
    }
    catch (error) {
      rethrow;
    }
    finally {
      setCampaignLoading(false);
    }
  }
}