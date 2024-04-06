import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/user/other_profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/error.dart';
import 'package:unidy_mobile/widgets/list_item.dart';
import 'package:unidy_mobile/widgets/profile/profile_archievement.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({super.key});

  @override
  State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {
  SliverToBoxAdapter _buildProfileHeader() {
    User? user = Provider.of<VolunteerProfileViewModel>(context).user;

    return SliverToBoxAdapter(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: Image.network(
                          'https://ispe.org/sites/default/files/styles/hero_banner_large/public/banner-images/volunteer-page-hero-1900x600.png.webp?itok=JwOK6xl2',
                          fit: BoxFit.cover
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: -90,
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: PrimaryColor.primary500,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: CircleAvatar(
                          radius: 120,
                          backgroundImage: NetworkImage(
                            user?.image ?? 'https://api.dicebear.com/7.x/initials/png?seed=${user?.fullName}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 240,
                          child: Text(
                            user?.fullName ?? 'Không rõ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 240,
                        child: _buildButton(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 5, color: PrimaryColor.primary50)
          ],
        )
    );
  }

  Widget _buildButton() {
    VolunteerProfileViewModel viewModel = Provider.of<VolunteerProfileViewModel>(context);
    User? user = viewModel.user;
    if (user?.isFriend == true) {
      return FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.people_rounded, size: 20),
          label: const Text('Bạn bè')
      );
    }
    else if (user?.isRequesting == true) {
      return OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.person_add, size: 20),
          label: const Text('Đã gửi lời mời')
      );
    }
    else if (user?.isRequested == true) {
      return OutlinedButton.icon(
          onPressed: viewModel.onAcceptFriendRequest,
          icon: const Icon(Icons.person_add, size: 20),
          label: const Text('Chấp nhận lời mời')
      );
    }

    return OutlinedButton.icon(
        onPressed: viewModel.onSendFriendRequest,
        icon: const Icon(Icons.person_add, size: 20),
        label: const Text('Kết bạn')
    );
  }

  SliverToBoxAdapter _buildProfileInfo() {
    User? user = Provider.of<VolunteerProfileViewModel>(context).user;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thông tin cá nhân',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        )
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Ngày sinh: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      Formatter.formatTime(user?.dayOfBirth, 'dd/MM/yyyy - HH:mm').toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Giới tính: ', style: Theme.of(context).textTheme.labelLarge,),
                    Text(user?.sex ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Công việc: ', style: Theme.of(context).textTheme.labelLarge,),
                    Text(user?.job ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Tại: ', style: Theme.of(context).textTheme.labelLarge,),
                    Text(user?.workLocation ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                  ],
                )
              ],
            ),
          ),
          const Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildProfileAchievement() {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          ProfileAchievement(),
          Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      ),
    );
  }

  Widget _buildRecentPost() {
    VolunteerProfileViewModel volunteerProfileViewModel = Provider.of<VolunteerProfileViewModel>(context);
    List<Post> postList = volunteerProfileViewModel.posts;

    if (postList.isEmpty) {
      return const SliverToBoxAdapter(
        child: Empty(description: 'Chưa có bài đăng nào')
      );
    }

    return SliverListItem<Post>(
      items: postList,
      length: postList.length,
      itemBuilder: (BuildContext context, int index) {
        Post post = postList[index];
        return PostCard(post: post);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
      isFirstLoading: volunteerProfileViewModel.isLoading,
      isLoading: volunteerProfileViewModel.isLoadingMore,
      error: volunteerProfileViewModel.error,
      onRetry: volunteerProfileViewModel.loadMoreData,
      onLoadMore: volunteerProfileViewModel.loadMoreData,
    );
  }

  @override
  Widget build(BuildContext context) {
    VolunteerProfileViewModel volunteerProfileViewModel = Provider.of<VolunteerProfileViewModel>(context);
    if (volunteerProfileViewModel.error) {
      return ErrorPlaceholder(
        onRetry: () => volunteerProfileViewModel.refreshData()
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tình nguyện viên'),
      ),
      body: Skeletonizer(
          enabled: volunteerProfileViewModel.isLoading,
          child: CustomScrollView(
            slivers: [
              _buildProfileHeader(),
              _buildProfileInfo(),
              _buildProfileAchievement(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text('Bài đăng gần đây', style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              _buildRecentPost()
            ],
          ),
        ),
    );
  }
}
