import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/user/detail_profile/organization_profile/organization_profile.dart';
import 'package:unidy_mobile/viewmodel/user/other_profile_viewmodel.dart';

class OrganizationProfileContainer extends StatefulWidget {
  final int organizationId;
  const OrganizationProfileContainer({super.key, required this.organizationId});

  @override
  State<OrganizationProfileContainer> createState() => _OrganizationProfileContainerState();
}

class _OrganizationProfileContainerState extends State<OrganizationProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrganizationProfileViewModel(organizationId: widget.organizationId),
      child: const OrganizationProfileScreen(),
    );
  }
}
