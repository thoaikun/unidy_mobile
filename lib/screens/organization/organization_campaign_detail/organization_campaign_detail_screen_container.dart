import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/viewmodel/organization/organization_campaign_detail_viewmodel.dart';

import 'organization_campaign_detail_screen.dart';

class OrganizationCampaignDetailScreenContainer extends StatefulWidget {
  final Campaign campaign;
  const OrganizationCampaignDetailScreenContainer({super.key, required this.campaign});

  @override
  State<OrganizationCampaignDetailScreenContainer> createState() => _OrganizationCampaignDetailScreenContainerState();
}

class _OrganizationCampaignDetailScreenContainerState extends State<OrganizationCampaignDetailScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrganizationCampaignDetailViewModel(campaign: widget.campaign),
      child: const OrganizationCampaignDetailScreen(),
    );
  }
}
