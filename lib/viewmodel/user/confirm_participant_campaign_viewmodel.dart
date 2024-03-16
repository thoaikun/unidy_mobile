import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/services/campaign_service.dart';

class ConfirmParticipantCampaignViewModel extends ChangeNotifier {
  void Function(String message) showAlertDialog;
  final CampaignService _campaignService = GetIt.instance<CampaignService>();

  bool _isConfirm = false;
  bool get isConfirm => _isConfirm;

  ConfirmParticipantCampaignViewModel({
    required this.showAlertDialog,
  });

  Future<void> onConfirm(String campaignId) async {
    try {
      await _campaignService.registerAsVolunteer(campaignId);
      showAlertDialog.call('Đăng ký tham gia thành công');
      _isConfirm = true;
      notifyListeners();
    }
    catch (error) {
      print(error);
      showAlertDialog.call('Đăng ký tham gia thất bại');
    }
  }
}