import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/utils/index.dart';
import 'package:unidy_mobile/viewmodel/user/home/dashboard_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';

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
        Provider.of<DashboardViewModel>(context, listen: false).setIsLoadMoreLoading(true);
        Provider.of<DashboardViewModel>(context, listen: false).getPosts();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DashboardViewModel dashboardViewModel = Provider.of<DashboardViewModel>(context, listen: false);
    dashboardViewModel.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (BuildContext context, DashboardViewModel dashboardViewModel, Widget? child) {
        return RefreshIndicator(
          onRefresh: () async {
            dashboardViewModel.getPosts();
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
        return ListView.separated(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            if (index < dashboardViewModel.postList.length) {
              Post post = dashboardViewModel.postList[index];
              return PostCard(
                  post: post,
                  userName: post.userNodes?.fullName,
                  avatarUrl: post.userNodes?.profileImageLink,
                  onLikePost: () => debounce(() => dashboardViewModel.handleLikePost(post), 500).call()
              );
            }
            else if (index == dashboardViewModel.postList.length && dashboardViewModel.isLoadMoreLoading) {
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
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
          itemCount: dashboardViewModel.postList.length + 1,
        );
      }
    );
  }

  Widget _buildPostCardListSkeleton() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return const PostCard(

        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
      itemCount: 5,
    );
  }
}
