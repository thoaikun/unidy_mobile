import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/viewmodel/organization/home/organization_campaign_history_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/organization_campaign_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/error.dart';
import 'package:unidy_mobile/widgets/list_item.dart';
import 'package:unidy_mobile/widgets/loadmore_indicator.dart';

class CampaignHistory extends StatefulWidget {
  const CampaignHistory({super.key});

  @override
  State<CampaignHistory> createState() => _CampaignHistoryState();
}

class _CampaignHistoryState extends State<CampaignHistory> {
  @override
  Widget build(BuildContext context) {
    OrganizationCampaignHistoryViewModel viewModel = Provider.of<OrganizationCampaignHistoryViewModel>(context);
    List<Campaign> campaigns = viewModel.campaigns;

    if (viewModel.isFirstLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (campaigns.isEmpty) {
      return const Empty(description: 'Chưa có chiến dịch nào.');
    }
    else if (viewModel.error) {
      return ErrorPlaceholder(onRetry: () => viewModel.refresh());
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: RefreshIndicator(
        onRefresh: () async {
          return Future.delayed(const Duration(seconds: 1))
              .then((value) => viewModel.initData());
        },
        backgroundColor: Colors.white,
        strokeWidth: 2,
        notificationPredicate: (ScrollNotification notification) {
          return notification.depth == 0;
        },
        child: ListItem<Campaign>(
          length: campaigns.length,
          items: campaigns,
          isLoading: viewModel.isLoading,
          isFirstLoading: viewModel.isFirstLoading,
          error: viewModel.error,
          onRetry: () => viewModel.loadMore(),
          onLoadMore: () => viewModel.loadMore(),
          itemBuilder: (BuildContext context, int index) {
            return OrganizationCampaignCard(campaign: campaigns[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
        )
      ),
    );
  }
}
