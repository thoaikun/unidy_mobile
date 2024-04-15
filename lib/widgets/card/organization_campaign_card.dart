import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/screens/organization/organization_campaign_detail/organization_campaign_detail_screen.dart';
import 'package:unidy_mobile/screens/organization/organization_campaign_detail/organization_campaign_detail_screen_container.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/widgets/status_tag.dart';

class OrganizationCampaignCard extends StatelessWidget {
  final Campaign campaign;
  const OrganizationCampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationCampaignDetailScreenContainer(campaign: campaign))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: TextColor.textColor200)
        ),
        child: Column(
          children: [
            _buildImage(),
            _buildCampaignInfo()
          ],
        )
      ),
    );
  }

  Widget _buildCampaignInfo() {
    return Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(campaign.title ?? 'Không rõ', style: Theme.of(context).textTheme.titleMedium,),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đã ủng hộ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
                      ),
                      Text(Formatter.formatCurrency(campaign.donationBudgetReceived ?? 0))
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 20,
                    color: TextColor.textColor200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mục tiêu',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
                      ),
                      Text(Formatter.formatCurrency(campaign.donationBudget ?? 0))
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 20,
                    color: TextColor.textColor200,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tham gia',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300)
                      ),
                      Text('${campaign.numberVolunteer ?? 0}')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cập nhật sự kiện'),
                )
              )
            ],
          ),
        );
      }
    );
  }

  Widget _buildImage() {
    List<dynamic> imageUrls = [];
    if (campaign.linkImage != "") {
      imageUrls = List<String>.from(jsonDecode(campaign.linkImage ?? '[]'));
    }

    return Builder(
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
              imageUrls.isNotEmpty
                ? Image.network(
                  imageUrls[0],
                  height: 240,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      width: double.infinity,
                      height: 240,
                      child: Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                )
            : Image.asset(
              'assets/imgs/placeholder.png', // if your image is in a different package
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
            Positioned(
                left: 10,
                top: 0,
                child: StatusTag(label: campaign.status == CampaignStatus.done  ? 'ĐÃ KẾT THÚC' : Formatter.calculateTimeRemain(campaign.startDate, campaign.endDate))
            ),
          ],
        );
      }
    );
  }
}
