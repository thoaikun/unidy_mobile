import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_joined_history_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/viewmodel/user/home/history_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/campaign_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with TickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _campaignScrollController = ScrollController();
  final ScrollController _donationScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _campaignScrollController.addListener(_handleControllerBehavior);
    _donationScrollController.addListener(_handleControllerBehavior);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _campaignScrollController.dispose();
    _donationScrollController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    HistoryViewModel historyViewModel = Provider.of<HistoryViewModel>(context, listen: false);
    historyViewModel.setCurrentTab(_tabController.index == 0 ? EHistoryTab.campaign : EHistoryTab.donation);
  }

  void _handleControllerBehavior() {
    HistoryViewModel historyViewModel = Provider.of<HistoryViewModel>(context, listen: false);
    if (_tabController.index == 1) {
      if (_donationScrollController.position.pixels == _donationScrollController.position.maxScrollExtent) {
        historyViewModel.loadMore();
      }
    }
    else {
      if (_campaignScrollController.position.pixels == _campaignScrollController.position.maxScrollExtent) {
        historyViewModel.loadMore();
      }
    }
  }

  Widget _buildJoinedCampaignList() {
    HistoryViewModel historyViewModel = Provider.of<HistoryViewModel>(context, listen: true);
    List<CampaignJoinedHistory> joinedCampaignList = historyViewModel.joinedCampaignList;

    if (historyViewModel.isFirstLoadingCampaign) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if (joinedCampaignList.isEmpty) {
      return const Empty(description: 'Chưa tham gia hoạt động nào');
    }

    return RefreshIndicator(
      onRefresh: () async {
        return Future.delayed(const Duration(seconds: 1))
            .then((value) => historyViewModel.refresh());
      },
      backgroundColor: Colors.white,
      strokeWidth: 2,
      notificationPredicate: (ScrollNotification notification) {
        return notification.depth == 0;
      },
      child: ListView.separated(
        controller: _campaignScrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == joinedCampaignList.length && historyViewModel.isLoadingCampaign) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          else if (index < joinedCampaignList.length) {
            CampaignJoinedHistory campaignJoinedHistory = joinedCampaignList[index];
            return CampaignJoinedCard(history: campaignJoinedHistory);
          }
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        itemCount: joinedCampaignList.length + 1,
      ),
    );
  }

  Widget _buildDonationCampaignList() {
    HistoryViewModel historyViewModel = Provider.of<HistoryViewModel>(context, listen: true);
    List<DonationHistory> donationHistoryList = historyViewModel.donationHistoryList;

    if (historyViewModel.isFirstLoadingDonation) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if (donationHistoryList.isEmpty) {
      return const Empty(description: 'Chưa có hoạt động quyên góp nào');
    }

    return RefreshIndicator(
      onRefresh: () async {
        return Future.delayed(const Duration(seconds: 1))
            .then((value) => historyViewModel.refresh());
      },
      backgroundColor: Colors.white,
      strokeWidth: 2,
      notificationPredicate: (ScrollNotification notification) {
        return notification.depth == 0;
      },
      child: ListView.separated(
        controller: _donationScrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == donationHistoryList.length && historyViewModel.isLoadingDonation) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          else if (index < donationHistoryList.length) {
            DonationHistory donationHistory = donationHistoryList[index];
            return CampaignDonationCard(history: donationHistory);
          }
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        itemCount: donationHistoryList.length + 1,
      ),
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
