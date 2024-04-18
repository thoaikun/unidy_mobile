import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/services/campaign_service.dart';

import '../../models/user_model.dart';

class ConfirmParticipantCampaignViewModel extends ChangeNotifier {
  void Function(String message) showAlertDialog;
  final CampaignService _campaignService = GetIt.instance<CampaignService>();
  final AppPreferences _appPreferences = GetIt.instance<AppPreferences>();

  bool _isConfirm = false;
  bool get isConfirm => _isConfirm;
  User? _user;
  User? get user => _user;

  ConfirmParticipantCampaignViewModel({
    required this.showAlertDialog,
  }) {
    String? data = _appPreferences.getString('profile');
    if (data != null) {
      Map<String, dynamic> json = jsonDecode(data);
      _user = User.fromJson(json);
    }
  }

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