import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/viewmodel/dashboard_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DashboardViewModel>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (BuildContext context, DashboardViewModel dashboardViewModel, Widget? child) {
        return RefreshIndicator(
          onRefresh: () async {
            print('refresh');
            dashboardViewModel.initData();
          },
          child: Skeletonizer(
            enabled: dashboardViewModel.loading,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Post post = dashboardViewModel.postList[index];
                return PostCard(
                  post: post,
                  userName: post.userNodes?.fullName,
                  avatarUrl: post.userNodes?.profileImageLink
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
              itemCount: dashboardViewModel.postList.length,
            ),
          ),
        );
      }
    );
  }
}
