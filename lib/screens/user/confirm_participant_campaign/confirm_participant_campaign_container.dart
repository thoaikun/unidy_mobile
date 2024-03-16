import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/screens/user/confirm_participant_campaign/confirm_participant_campaign.dart';
import 'package:unidy_mobile/viewmodel/user/confirm_participant_campaign_viewmodel.dart';

class ConfirmParticipantCampaignContainer extends StatefulWidget {
  final CampaignPost campaignPost;
  const ConfirmParticipantCampaignContainer({super.key, required this.campaignPost});

  @override
  State<ConfirmParticipantCampaignContainer> createState() => _ConfirmParticipantCampaignContainerState();
}

class _ConfirmParticipantCampaignContainerState extends State<ConfirmParticipantCampaignContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConfirmParticipantCampaignViewModel(showAlertDialog: showAlertDialog),
      child: ConfirmParticipantCampaign(campaignPost: widget.campaignPost),
    );
  }

  void showAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              )
            ],
          );
        }
    );
  }
}
