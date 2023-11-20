import 'package:flutter/material.dart';
import 'package:unidy_mobile/widgets/card/organization_campaign_card.dart';

class CampaignHistory extends StatefulWidget {
  const CampaignHistory({super.key});

  @override
  State<CampaignHistory> createState() => _CampaignHistoryState();
}

class _CampaignHistoryState extends State<CampaignHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) => const OrganizationCampaignCard(),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25),
        itemCount: 6,
      ),
    );
  }
}
