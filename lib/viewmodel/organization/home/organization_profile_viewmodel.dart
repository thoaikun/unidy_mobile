import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/bloc/organization_profile_cubit.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/services/organization_service.dart';

class OrganizationProfileViewModel extends ChangeNotifier {
  final OrganizationService _organizationService = GetIt.instance<OrganizationService>();
  BuildContext context;

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

  OrganizationProfileViewModel({ required this.context }) {
    Organization organization = context.read<OrganizationProfileCubit>().state;
    if (organization.organizationName == '') {
      getOrganizationProfile();
      context.read<OrganizationProfileCubit>().setProfile(organization);
    }
  }

  void getOrganizationProfile() async {
    organization = await _organizationService.whoAmI();
    notifyListeners();
  }
}