import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/screens/user/campaign_detail/campaign_detail_screen.dart';
import 'package:unidy_mobile/viewmodel/user/detail_campaign_viewmodel.dart';

class CampaignDetailScreenContainer extends StatefulWidget {
  final String? campaignId;
  final Campaign? campaign;
  const CampaignDetailScreenContainer({super.key, this.campaign, this.campaignId});

  @override
  State<CampaignDetailScreenContainer> createState() => _CampaignDetailScreenContainerState();
}

class _CampaignDetailScreenContainerState extends State<CampaignDetailScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailCampaignViewModel(campaignId: widget.campaignId, campaign: widget.campaign),
      child: const CampaignDetailScreen(),
    );
  }
}
