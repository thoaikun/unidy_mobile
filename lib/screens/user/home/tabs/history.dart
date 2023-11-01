import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/card/campaign_card.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildJoinedCampaignList() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => const CampaignJoinedCard(),
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
      itemCount: 5,
    );
  }

  Widget _buildDonationCampaignList() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => const CampaignDonationCard(),
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
      itemCount: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          labelColor: PrimaryColor.primary500,
          unselectedLabelColor: TextColor.textColor300,
          tabs: const <Widget>[
            Tab(text: 'Hoạt động tham gia'),
            Tab(text: 'Quyên góp'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildJoinedCampaignList(),
              _buildDonationCampaignList()
            ],
          ),
        ),
      ],
    );
  }
}
