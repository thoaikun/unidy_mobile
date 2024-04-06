import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/screens/organization/home/organization_home_screen.dart';
import 'package:unidy_mobile/viewmodel/navigation_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/organization/home/organization_campaign_history_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/organization/home/organization_dashboard_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/organization/home/organization_profile_viewmodel.dart';

class OrganizationHomeScreenContainer extends StatefulWidget {
  const OrganizationHomeScreenContainer({super.key});

  @override
  State<OrganizationHomeScreenContainer> createState() => _OrganizationHomeScreenContainerState();
}

class _OrganizationHomeScreenContainerState extends State<OrganizationHomeScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NavigationViewModel()),
          ChangeNotifierProvider(create: (_) => OrganizationProfileViewModel()),
          ChangeNotifierProvider(create: (_) => OrganizationDashboardViewModel()),
          ChangeNotifierProvider(create: (_) => OrganizationCampaignHistoryViewModel())
        ],
        child: const OrganizationHomeScreen()
    );
  }
}
