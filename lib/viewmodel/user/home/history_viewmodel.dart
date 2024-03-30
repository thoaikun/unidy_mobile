import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_joined_history_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

enum EHistoryTab {
  campaign,
  donation,
}

class HistoryViewModel extends ChangeNotifier {
  final UserService _userService = GetIt.instance<UserService>();

  EHistoryTab _currentTab = EHistoryTab.campaign;
  final int LIMIT = 5;
  int _campaignPage = 0;
  int _donationPage = 0;
  bool isFirstLoadingCampaign = true;
  bool isFirstLoadingDonation = true;
  bool isLoadingCampaign = false;
  bool isLoadingDonation = false;
  bool campaignError = false;
  bool donationError = false;

  List<CampaignJoinedHistory> _joinedCampaignList = [];
  List<DonationHistory> _donationHistoryList = [];
  List<CampaignJoinedHistory> get joinedCampaignList => _joinedCampaignList;
  List<DonationHistory> get donationHistoryList => _donationHistoryList;

  HistoryViewModel() {
    getData();
  }

  void setCurrentTab(EHistoryTab tab) {
    _currentTab = tab;
    getData();
  }

  void setFirstCampaignLoading(bool value) {
    isFirstLoadingCampaign = value;
    notifyListeners();
  }

  void setFirstDonationLoading(bool value) {
    isFirstLoadingDonation = value;
    notifyListeners();
  }

  void setCampaignLoading(bool isLoading) {
    isLoadingCampaign = isLoading;
    notifyListeners();
  }

  void setDonationLoading(bool isLoading) {
    isLoadingDonation = isLoading;
    notifyListeners();
  }

  void setCampaignList(List<CampaignJoinedHistory> list) {
    _campaignPage += 1;
    _joinedCampaignList = [..._joinedCampaignList, ...list];
    notifyListeners();
  }

  void setDonationList(List<DonationHistory> list) {
    _donationPage += 1;
    _donationHistoryList = [..._donationHistoryList, ...list];
    notifyListeners();
  }

  Future<void> getData() async {
    switch (_currentTab) {
      case EHistoryTab.campaign:
        try {
          if (_joinedCampaignList.isNotEmpty) return;
          List<CampaignJoinedHistory> histories = await _userService.getJoinedCampaign(page: _campaignPage, size: LIMIT);
          setCampaignList(histories);
        } catch (e) {
          campaignError = true;
          notifyListeners();
        }
        finally {
          setFirstCampaignLoading(false);
        }
        break;
      case EHistoryTab.donation:
        try {
          if (_donationHistoryList.isNotEmpty) return;
          List<DonationHistory> histories = await _userService.getDonationHistory(page: _donationPage, size: LIMIT);
          setDonationList(histories);
        } catch (e) {
          donationError = true;
          notifyListeners();
        }
        finally {
          setFirstDonationLoading(false);
        }
        break;
    }
  }

  void loadMore() async {
    switch (_currentTab) {
      case EHistoryTab.campaign:
        try {
          setCampaignLoading(true);
          List<CampaignJoinedHistory> histories = await _userService.getJoinedCampaign(page: _campaignPage, size: LIMIT);
          if (histories.isNotEmpty) {
            setCampaignList(histories);
          }
        }
        catch (e) {
          campaignError = true;
          notifyListeners();
        }
        finally {
          setCampaignLoading(false);
        }
        break;
      case EHistoryTab.donation:
        try {
          setDonationLoading(true);
          List<DonationHistory> histories = await _userService.getDonationHistory(page: _donationPage, size: LIMIT);
          if (histories.isNotEmpty) {
            setDonationList(histories);
          }
        }
        catch (e) {
          donationError = true;
          notifyListeners();
        }
        finally {
          setDonationLoading(false);
        }
        break;
    }
  }

  void refresh() {
    switch (_currentTab) {
      case EHistoryTab.campaign:
        _joinedCampaignList = [];
        _campaignPage = 0;
        setFirstCampaignLoading(true);
        break;
      case EHistoryTab.donation:
        _donationPage = 0;
        _donationHistoryList = [];
        setFirstDonationLoading(true);
        break;
    }
    getData();
  }
}