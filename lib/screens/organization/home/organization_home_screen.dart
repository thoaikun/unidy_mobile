import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/organization_profile_cubit.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/screens/organization/home/tabs/organization_campaign_history.dart';
import 'package:unidy_mobile/screens/organization/home/tabs/organization_dashboard.dart';
import 'package:unidy_mobile/screens/organization/home/tabs/organization_profile.dart';
import 'package:unidy_mobile/viewmodel/navigation_viewmodel.dart';
import 'package:unidy_mobile/viewmodel/organization/home/organization_profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/navigation/organization_appbar.dart';
import 'package:unidy_mobile/widgets/navigation/organization_bottom_navigation_bar.dart';

class OrganizationHomeScreen extends StatefulWidget {
  const OrganizationHomeScreen({super.key});

  @override
  State<OrganizationHomeScreen> createState() => _OrganizationHomeScreenState();
}

class _OrganizationHomeScreenState extends State<OrganizationHomeScreen> {
  final List<Widget> _screenOptions = [
    const Dashboard(),
    const CampaignHistory(),
    const OrganizationProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (BuildContext context, NavigationViewModel navigationViewModel, Widget? child) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: UnidyOrganizationAppBar()
        ),
        bottomNavigationBar: const OrganizationBottomNavigationBar(),
        body: _screenOptions[navigationViewModel.currentScreen]
      )
    );
  }
}
