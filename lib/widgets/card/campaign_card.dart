import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/screens/user/campaign_detail/campaign_detail.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/widgets/status_tag.dart';

class CampaignJoinedCard extends StatelessWidget {
  const CampaignJoinedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CampaignDetailScreen())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/6/6c/Vilnius_Marathon_2015_volunteers_by_Augustas_Didzgalvis.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            _buildInfo(context)
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Ten chiến dịch',
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 30),
            const StatusTag(label: 'Đã tham gia', type: StatusType.info),
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
                  Formatter.formatTime(DateTime.now(), 'dd/MM/yyyy - HH:mm').toString(),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Thời gian diễn ra: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                const Text(
                  '12/12/2023'
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Tình nguyện viên: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                const Text(
                  '${100}/${120} người',
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
  const CampaignDonationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CampaignDetailScreen())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/6/6c/Vilnius_Marathon_2015_volunteers_by_Augustas_Didzgalvis.jpg',
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator()
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object child, StackTrace? error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            _buildInfo(context)
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Ten chiến dịch nó rất là dài đó nên làm sao thì làm nha mng',
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 30),
            const StatusTag(label: 'Đã tham gia', type: StatusType.success),
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
                  Formatter.formatTime(DateTime.now(), 'dd/MM/yyyy - HH:mm').toString(),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Thời gian diễn ra: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                ),
                const Text(
                    '12/12/2023'
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
                  '145 triệu đồng',
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
