import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/services/organization_service.dart';

class OrganizationProfileViewModel extends ChangeNotifier {
  final OrganizationService _organizationService = GetIt.instance<OrganizationService>();

  Organization organization = Organization(
    userId: 0,
    organizationName: '',
    address: '',
    phone: '',
    email: '',
    country: '',
    firebaseTopic: '',
    image: '',
    isFollow: false,
    overallFigure: null
  );

  Future<void> getOrganizationProfile() async {
    organization = await _organizationService.whoAmI();
    notifyListeners();
  }
}