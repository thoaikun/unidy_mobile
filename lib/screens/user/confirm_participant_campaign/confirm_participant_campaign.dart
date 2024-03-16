import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/viewmodel/user/confirm_participant_campaign_viewmodel.dart';

class ConfirmParticipantCampaign extends StatefulWidget {
  final CampaignPost campaignPost;
  const ConfirmParticipantCampaign({super.key, required this.campaignPost});

  @override
  State<ConfirmParticipantCampaign> createState() => _ConfirmParticipantCampaignState();
}

class _ConfirmParticipantCampaignState extends State<ConfirmParticipantCampaign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác nhận tham gia chiến dịch'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Consumer<ConfirmParticipantCampaignViewModel>(
          builder: (BuildContext context, ConfirmParticipantCampaignViewModel confirmParticipantCampaignViewModel, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPersonalInfo(),
                const SizedBox(height: 10),
                const Divider(thickness: 0.5),
                const SizedBox(height: 10),
                _buildCampaignInfo(),
                const Spacer(),
                _buildActionButton()
              ]
            );
          }
        ),
      )
    );
  }

  Widget _buildPersonalInfo() {
    User user = context.read<ProfileCubit>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông tin cá nhân', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('Họ và tên: '),
            Text(user.fullName ?? 'Chưa cập nhật'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('Số điện thoại: '),
            Text(user.phone ?? 'Chưa cập nhật'),
          ],
        )
      ],
    );
  }

  Widget _buildCampaignInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thông tin chiến dịch', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('Tên chiến dịch: '),
            Text(widget.campaignPost.campaign.title ?? 'Chưa cập nhật'),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            const Text('Thời gian diễn ra: '),
            Text(widget.campaignPost.campaign.timeTakePlace ?? 'Chưa cập nhật')
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            const Text('Nơi diễn ra: '),
            Text(widget.campaignPost.campaign.location),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    ConfirmParticipantCampaignViewModel confirmParticipantCampaignViewModel = Provider.of<ConfirmParticipantCampaignViewModel>(context, listen: true);

    if (confirmParticipantCampaignViewModel.isConfirm) {
      return Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: PrimaryColor.primary500),
          borderRadius: BorderRadius.circular(5)
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check, color: PrimaryColor.primary500),
            Text('Đã xác nhận tham gia', style: TextStyle(color: PrimaryColor.primary500))
          ],
        ),
      );
    }
    else {
      return SizedBox(
        width: double.infinity,
        height: 45,
        child: FilledButton(
          onPressed: () => confirmParticipantCampaignViewModel.onConfirm(widget.campaignPost.campaign.campaignId),
          child: const Text('Xác nhận tham gia'),
        ),
      );
    }
  }
}
