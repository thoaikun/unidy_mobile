import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_joined_history_model.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/screens/user/campaign_detail/campaign_detail_screen.dart';
import 'package:unidy_mobile/screens/user/campaign_detail/campaign_detail_screen_container.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/widgets/status_tag.dart';

class CampaignJoinedCard extends StatelessWidget {
  final CampaignJoinedHistory history;
  const CampaignJoinedCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CampaignDetailScreenContainer(campaign: history.campaign))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _buildInfo(context)
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    Widget status = const StatusTag(label: 'Đã kết thúc', type: StatusType.success);
    if (history.campaign.status == CampaignStatus.inProgress) {
      status = const StatusTag(label: 'Đang diễn ra', type: StatusType.info);
    }
    else if (history.campaign.status == CampaignStatus.canceled) {
      status = const StatusTag(label: 'Đã hủy', type: StatusType.error);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                history.campaign.title ?? 'Không có tiêu đề',
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 30),
            status
          ],
        ),
        Wrap(
          runSpacing: 8,
          children: [
            Row(
              children: [
                Text(
                  'Đăng ký lúc: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                Text(
                  Formatter.formatTime(history.timeJoin, 'dd/MM/yyyy - HH:mm').toString(),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Thời gian diễn ra: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                Text(
                  history.campaign.timeTakePlace ?? ''
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Tình nguyện viên: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                Text(
                  '${history.campaign.numberVolunteerRegistered}/${history.campaign.numberVolunteer} nguòi'
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class CampaignDonationCard extends StatelessWidget {
  final DonationHistory history;
  const CampaignDonationCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CampaignDetailScreenContainer(campaign: history?.campaign))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _buildInfo(context)
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    Widget status = const StatusTag(label: 'Đã kết thúc', type: StatusType.success);
    if (history.campaign?.status == CampaignStatus.inProgress) {
      status = const StatusTag(label: 'Đang diễn ra', type: StatusType.info);
    }
    else if (history.campaign?.status == CampaignStatus.canceled) {
      status = const StatusTag(label: 'Đã hủy', type: StatusType.error);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                history.campaign?.title ?? 'Không có tiêu đề',
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 30),
            status
          ],
        ),
        Wrap(
          runSpacing: 8,
          children: [
            Row(
              children: [
                Text(
                  'Ủng hộ lúc: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                Text(
                  Formatter.formatTime(history.transactionTime, 'dd/MM/yyyy - HH:mm').toString(),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Thời gian diễn ra: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                Text(
                    history.campaign?.timeTakePlace ?? ''
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Phương thức thanh toán: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                const Text(
                  'Momo',
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Số tiền ủng hộ: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                Text(
                  Formatter.formatCurrency(history.transactionAmount),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ErrorColor.error500),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
