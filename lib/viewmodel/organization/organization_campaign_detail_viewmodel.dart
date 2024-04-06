import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/models/volunteer_join_campaign_model.dart';
import 'package:unidy_mobile/services/organization_service.dart';

class OrganizationCampaignDetailViewModel extends ChangeNotifier {
  final OrganizationService _organizationService = GetIt.instance<OrganizationService>();
  Campaign campaign;

  final TextEditingController _confirmEndCampaignController = TextEditingController();
  BehaviorSubject<String> _endCampaignSubject = BehaviorSubject<String>();

  final int _limit = 5;
  int _unapprovedVolunteersPage = 0;
  int _approvedVolunteersPage = 0;
  int _donationHistoriesPage = 0;

  List<int> _selectedRequestVolunteers = [];
  List<VolunteerJoinCampaign> _listUnapprovedVolunteers = [];
  List<VolunteerJoinCampaign> _listApprovedVolunteers = [];
  List<DonationHistory> _listDonationHistories = [];
  TextEditingController get confirmEndCampaignController => _confirmEndCampaignController;

  bool isUnapprovedVolunteersFirstLoading = true;
  bool isApprovedVolunteersFirstLoading = true;
  bool isDonationHistoriesFirstLoading = true;
  bool isUnapprovedVolunteersLoading = false;
  bool isApprovedVolunteersLoading = false;
  bool isDonationHistoriesLoading = false;
  bool updateLoading = false;

  bool unapprovedVolunteersError = false;
  bool approvedVolunteersError = false;
  bool donationHistoriesError = false;
  String? endCampaignError = null;

  List<int> get selectedRequestVolunteers => _selectedRequestVolunteers;
  List<VolunteerJoinCampaign> get listUnapprovedVolunteers => _listUnapprovedVolunteers;
  List<VolunteerJoinCampaign> get listApprovedVolunteers => _listApprovedVolunteers;
  List<DonationHistory> get listDonationHistories => _listDonationHistories;

  OrganizationCampaignDetailViewModel({required this.campaign}) {
    _endCampaignSubject.stream.listen((event) {
      _organizationService.endCampaign(campaign.campaignId)
        .then((value) {
          campaign.status = CampaignStatus.done;
          notifyListeners();
        })
        .catchError((error) {
          setEndCampaignError('Failed to end campaign');
        });
    });

    initData();
  }

  void onSelectAll(bool? changed) {
    if (changed == true) {
      addAllSelectedRequestVolunteers();
    } else {
      removeAllSelectedRequestVolunteers();
    }
  }

  void addSelectedRequestVolunteer(int volunteerId) {
    _selectedRequestVolunteers.add(volunteerId);
    notifyListeners();
  }

  void addAllSelectedRequestVolunteers() {
    for (var element in _listUnapprovedVolunteers) {
      _selectedRequestVolunteers.add(element.userId);
    }
    notifyListeners();
  }

  void removeAllSelectedRequestVolunteers() {
    _selectedRequestVolunteers.clear();
    notifyListeners();
  }

  void removeSelectedRequestVolunteer(int volunteerId) {
    _selectedRequestVolunteers.remove(volunteerId);
    notifyListeners();
  }

  void setCampaign(Campaign value) {
    campaign = value;
    notifyListeners();
  }

  void setUnapprovedVolunteersFirstLoading(bool value) {
    isUnapprovedVolunteersFirstLoading = value;
    notifyListeners();
  }

  void setApprovedVolunteersFirstLoading(bool value) {
    isApprovedVolunteersFirstLoading = value;
    notifyListeners();
  }

  void setDonationHistoriesFirstLoading(bool value) {
    isDonationHistoriesFirstLoading = value;
    notifyListeners();
  }

  void setUnapprovedVolunteersLoading(bool value) {
    isUnapprovedVolunteersLoading = value;
    notifyListeners();
  }

  void setApprovedVolunteersLoading(bool value) {
    isApprovedVolunteersLoading = value;
    notifyListeners();
  }

  void setDonationHistoriesLoading(bool value) {
    isDonationHistoriesLoading = value;
    notifyListeners();
  }

  void setUnapprovedVolunteersError(bool value) {
    unapprovedVolunteersError = value;
    notifyListeners();
  }

  void setApprovedVolunteersError(bool value) {
    approvedVolunteersError = value;
    notifyListeners();
  }

  void setDonationHistoriesError(bool value) {
    donationHistoriesError = value;
    notifyListeners();
  }

  void setEndCampaignError(String? value) {
    endCampaignError = value;
    notifyListeners();
  }

  void setUpdating(bool value) {
    updateLoading = value;
    notifyListeners();
  }

  void setUnapprovedVolunteers(List<VolunteerJoinCampaign> listUnapprovedVolunteers) {
    _listUnapprovedVolunteers = [..._listUnapprovedVolunteers, ...listUnapprovedVolunteers];
    _unapprovedVolunteersPage ++;
    notifyListeners();
  }

  void setApprovedVolunteers(List<VolunteerJoinCampaign> listApprovedVolunteers) {
    _listApprovedVolunteers = [..._listApprovedVolunteers, ...listApprovedVolunteers];
    _approvedVolunteersPage ++;
    notifyListeners();
  }

  void setDonationHistories(List<DonationHistory> listDonationHistories) {
    _listDonationHistories = [..._listDonationHistories, ...listDonationHistories];
    _donationHistoriesPage ++;
    notifyListeners();
  }

  void getUnapprovedVolunteers() async {
    try {
      setUnapprovedVolunteersError(false);
      List<VolunteerJoinCampaign> listUnapprovedVolunteers = await _organizationService.getNotApprovedVolunteersInCampaign(campaign.campaignId, pageNumber: _unapprovedVolunteersPage, pageSize: _limit);
      setUnapprovedVolunteers(listUnapprovedVolunteers);
    }
    catch (e) {
      setUnapprovedVolunteersError(true);
    }
  }

  void getApprovedVolunteers() async {
    try {
      setApprovedVolunteersError(false);
      List<VolunteerJoinCampaign> listApprovedVolunteers = await _organizationService.getApprovedVolunteersInCampaign(campaign.campaignId, pageNumber: _approvedVolunteersPage, pageSize: _limit);
      setApprovedVolunteers(listApprovedVolunteers);
    }
    catch (e) {
      setApprovedVolunteersError(true);
    }
  }

  void getDonationHistories() async {
    try {
      setDonationHistoriesError(false);
      List<DonationHistory> listDonationHistories = await _organizationService.getDonationsInCampaign(campaign.campaignId, pageNumber: _donationHistoriesPage, pageSize: _limit);
      setDonationHistories(listDonationHistories);
    }
    catch (e) {
      setDonationHistoriesError(true);
    }
  }

  void initData() {
    getUnapprovedVolunteers();
    getApprovedVolunteers();
    getDonationHistories();
    setApprovedVolunteersFirstLoading(false);
    setUnapprovedVolunteersFirstLoading(false);
    setDonationHistoriesFirstLoading(false);
  }

  void loadMoreUnapprovedVolunteers() {
    getUnapprovedVolunteers();
  }

  void loadMoreApprovedVolunteers() {
    getApprovedVolunteers();
  }

  void loadMoreDonationHistories() {
    getDonationHistories();
  }

  Future<void> onApproveVolunteers() async {
    try {
      setUpdating(true);
      await _organizationService.approveVolunteersInCampaign(campaign.campaignId, _selectedRequestVolunteers);
      _listUnapprovedVolunteers.removeWhere((element) => _selectedRequestVolunteers.contains(element.userId));
      _listApprovedVolunteers.addAll(_listUnapprovedVolunteers.where((element) => _selectedRequestVolunteers.contains(element.userId)).toList());
      if (campaign.numberVolunteerRegistered != null) {
        campaign.numberVolunteerRegistered = campaign.numberVolunteerRegistered! + _selectedRequestVolunteers.length;
      }
      else {
        campaign.numberVolunteerRegistered = _selectedRequestVolunteers.length;
      }
      _selectedRequestVolunteers.clear();
      notifyListeners();
    }
    catch (e) {
      rethrow;
    }
    finally {
      setUpdating(false);
    }
  }

  Future<void> onRejectVolunteers() async {
    try {
      setUpdating(true);
      await _organizationService.rejectVolunteersInCampaign(campaign.campaignId, _selectedRequestVolunteers);
      _listUnapprovedVolunteers.removeWhere((element) => _selectedRequestVolunteers.contains(element.userId));
      _selectedRequestVolunteers.clear();
      notifyListeners();
    }
    catch (error) {
      rethrow;
    }
    finally {
      setUpdating(false);
    }
  }

  void onEndCampaign() {
    _endCampaignSubject.sink.add(_confirmEndCampaignController.text);
  }
}