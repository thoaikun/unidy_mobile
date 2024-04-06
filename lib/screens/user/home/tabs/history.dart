import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_joined_history_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/viewmodel/user/home/history_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/campaign_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/list_item.dart';

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
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    HistoryViewModel historyViewModel = Provider.of<HistoryViewModel>(context, listen: false);
    historyViewModel.setCurrentTab(_tabController.index == 0 ? EHistoryTab.campaign : EHistoryTab.donation);
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
      child: ListItem<CampaignJoinedHistory>(
        items: joinedCampaignList,
        length: joinedCampaignList.length,
        itemBuilder: (BuildContext context, int index) {
          CampaignJoinedHistory joinedCampaign = joinedCampaignList[index];
          return CampaignJoinedCard(history: joinedCampaign);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        isFirstLoading: historyViewModel.isFirstLoadingCampaign,
        isLoading: historyViewModel.isLoadingCampaign,
        error: historyViewModel.campaignError,
        onRetry: historyViewModel.loadMore,
        onLoadMore: historyViewModel.loadMore,
      )
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
      child: ListItem<DonationHistory>(
        items: donationHistoryList,
        length: donationHistoryList.length,
        itemBuilder: (BuildContext context, int index) {
          DonationHistory donationHistory = donationHistoryList[index];
          return CampaignDonationCard(history: donationHistory);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        isFirstLoading: historyViewModel.isFirstLoadingDonation,
        isLoading: historyViewModel.isLoadingDonation,
        error: historyViewModel.donationError,
        onRetry: historyViewModel.loadMore,
        onLoadMore: historyViewModel.loadMore,
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
