import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/viewmodel/edit_campaign_viewmodel.dart';

import 'edit_campaign_screen.dart';

class EditCampaignScreenContainer extends StatefulWidget {
  final Campaign? campaign;
  final void Function(Campaign updatedData)? onUpdateCampaign;
  const EditCampaignScreenContainer({super.key, this.campaign, this.onUpdateCampaign});

  @override
  State<EditCampaignScreenContainer> createState() => _EditCampaignScreenContainerState();
}

class _EditCampaignScreenContainerState extends State<EditCampaignScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditCampaignViewModel(
        showSnackBar: (String content) => ScaffoldMessenger.of(context).showSnackBar(_buildSnakeBar(content)),
        onUpdateCampaign: widget.onUpdateCampaign,
        campaign: widget.campaign
      ),
      child: const EditCampaignScreen()
    );
  }

  SnackBar _buildSnakeBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
  }
}
