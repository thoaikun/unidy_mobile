import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/certificate_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';

enum EDetailCampaignTab {
  certificate,
  report,
}

class DetailCampaignViewModel extends ChangeNotifier {
  final CampaignService _campaignService = GetIt.instance<CampaignService>();

  EDetailCampaignTab _currentTab = EDetailCampaignTab.certificate;
  String? campaignId;
  Campaign? campaign;
  List<DonationHistory> _donations = [];
  Certificate? _certificate;
  final int LIMIT = 5;
  bool _isCertificateLoading = true;
  bool _isDonationLoading = true;
  bool _isLoadingMore = false;
  bool certificateError = false;
  bool reportError = false;

  EDetailCampaignTab get currentTab => _currentTab;
  List<DonationHistory> get donations => _donations;
  Certificate? get certificate => _certificate;
  bool get isCertificateLoading => _isCertificateLoading;
  bool get isDonationLoading => _isDonationLoading;
  bool get isMoreLoading => _isLoadingMore;

  DetailCampaignViewModel({this.campaignId, this.campaign}) {
    if (campaignId == null && campaign != null) {
      campaignId = campaign!.campaignId;
    }
    else if (campaignId != null && campaign == null) {
      getCampaignData();
    }
    initData();
  }

  void setDonations(List<DonationHistory> donations) {
    _donations.addAll(donations);
    notifyListeners();
  }

  void setCertificate(Certificate? certificate) {
    _certificate = certificate;
    notifyListeners();
  }

  void changeTab(EDetailCampaignTab tab) {
    _currentTab = tab;
    initData();
  }

  void setCertificateLoading(bool isLoading) {
    _isCertificateLoading = isLoading;
    notifyListeners();
  }

  void setDonationLoading(bool isLoading) {
    _isDonationLoading = isLoading;
    notifyListeners();
  }

  void setMoreLoading(bool isLoading) {
    _isLoadingMore = isLoading;
    notifyListeners();
  }

  void initData() async {
    switch (_currentTab) {
      case EDetailCampaignTab.certificate:
        try {
          if (!_isCertificateLoading) break;
          Certificate? certificate = await _campaignService.getCertificateInCampaign(campaignId ?? '0');
          setCertificate(certificate);
        }
        catch (e) {
          certificateError = true;
          notifyListeners();
        }
        finally {
          setCertificateLoading(false);
        }
        break;
      case EDetailCampaignTab.report:
        try {
          if (!_isDonationLoading) break;
          List<DonationHistory> donations = await _campaignService.getDonationsInCampaign(campaignId ?? '0', pageNumber: _donations.length, pageSize: LIMIT);
          setDonations(donations);
        }
        catch (e) {
          reportError = true;
          notifyListeners();
        }
        finally {
          setDonationLoading(false);
        }
        break;
    }
  }

  void loadMoreDonations() async {
    try {
      setMoreLoading(true);
      List<DonationHistory> donations = await _campaignService.getDonationsInCampaign(campaignId ?? '0', pageNumber: _donations.length, pageSize: LIMIT);
      setDonations(donations);
    }
    catch (e) {
      reportError = true;
      notifyListeners();
    }
    finally {
      setMoreLoading(false);
    }
  }

  void getCampaignData() async {
    try {
      campaign = await _campaignService.getCampaignByCampaignId(campaignId ?? '0');
      notifyListeners();
    }
    catch (e) {
      print(e);
    }
  }
}