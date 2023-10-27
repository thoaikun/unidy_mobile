import 'package:flutter/material.dart';

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

  Widget _buildJoinedCampaignList() {
    return const Card(
      margin: EdgeInsets.all(16.0),
      child: Center(
          child: Text('Hoạt động tham gia nè')),
    );
  }

  Widget _buildDonationCampaignList() {
    return const Card(
      margin: EdgeInsets.all(16.0),
      child: Center(
          child: Text('Quyên góp ở đây nè')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
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
