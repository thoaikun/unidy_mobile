import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/utils/index.dart';
import 'package:unidy_mobile/viewmodel/user/home/dashboard_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';
import 'package:unidy_mobile/widgets/error.dart';
import 'package:unidy_mobile/widgets/list_item.dart';
import 'package:unidy_mobile/widgets/loadmore_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<DashboardViewModel>(context, listen: false).loadMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (BuildContext context, DashboardViewModel dashboardViewModel, Widget? child) {
        if (dashboardViewModel.error) {
          return ErrorPlaceholder(
            onRetry: () => dashboardViewModel.refreshData(),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            return Future.delayed(const Duration(seconds: 1))
              .then((value) => dashboardViewModel.refreshData());
          },
          backgroundColor: Colors.white,
          strokeWidth: 2,
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 0;
          },
          child: Skeletonizer(
            enabled: dashboardViewModel.isFirstLoading,
            child: dashboardViewModel.isFirstLoading == false
              ? _buildPostCardList()
              : _buildPostCardListSkeleton(),
          ),
        );
      }
    );
  }

  Widget _buildPostCardList() {
    return Consumer<DashboardViewModel>(
      builder: (BuildContext context, DashboardViewModel dashboardViewModel, Widget? child) {
        return ListItem<dynamic>(
          items: dashboardViewModel.recommendationList,
          length: dashboardViewModel.recommendationList.length,
          itemBuilder: (BuildContext context, int index) {
            if (dashboardViewModel.recommendationList[index] is CampaignPost) {
              CampaignPost campaign = dashboardViewModel.recommendationList[index];
              return CampaignPostCard(
                campaignPost: campaign,
                onLike: () => dashboardViewModel.handleLikeCampaign(campaign),
              );
            }
            else {
              Post post = dashboardViewModel.recommendationList[index];
              return PostCard(
                post: post,
                onLike: () => dashboardViewModel.handleLikePost(post),
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
          isFirstLoading: dashboardViewModel.isFirstLoading,
          isLoading: dashboardViewModel.isLoadMoreLoading,
          error: dashboardViewModel.error,
          onRetry: dashboardViewModel.loadMoreData,
          onLoadMore: dashboardViewModel.loadMoreData,
        );
      }
    );
  }

  Widget _buildPostCardListSkeleton() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return PostCard().buildSkeleton(context);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
      itemCount: 5,
    );
  }
}
