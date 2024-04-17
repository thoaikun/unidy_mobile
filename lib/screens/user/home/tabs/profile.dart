import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/bloc/profile_cubit.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/screens/user/edit_profile/edit_profile_screen.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/user/home/profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';
import 'package:unidy_mobile/widgets/list_item.dart';
import 'package:unidy_mobile/widgets/profile/profile_archievement.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<ProfileViewModel>(context, listen: false).loadMorePosts();
      }
    });
  }
  
  SliverToBoxAdapter _buildProfileHeader(User user) {
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
                    bottom: -80,
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
                          user.image ?? 'https://api.dicebear.com/7.x/initials/png?seed=${user.fullName}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 10, 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 240,
                    child: Text(
                      user.fullName ?? 'Không rõ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
            ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      )
    );
  }

  SliverToBoxAdapter _buildProfileInfo() {
    User user =  Provider.of<ProfileViewModel>(context, listen: true).user;

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
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => EditProfileScreen(user: user)));
                          },
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
                        Formatter.formatTime(user.dayOfBirth, 'dd/MM/yyyy - HH:mm').toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Giới tính: ', style: Theme.of(context).textTheme.labelLarge,),
                      Text(user.sex ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Công việc: ', style: Theme.of(context).textTheme.labelLarge,),
                      Text(user.job ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Tại: ', style: Theme.of(context).textTheme.labelLarge,),
                      Text(user.workLocation ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
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

  SliverListItem<Post> _buildRecentPost(List<Post> postList, User user) {
    ProfileViewModel profileViewModel = Provider.of<ProfileViewModel>(context, listen: true);
    List<Post> postList = profileViewModel.postList;

    return SliverListItem<Post>(
        items: postList,
        length: postList.length,
        itemBuilder: (BuildContext context, int index) {
          Post post = postList[index];
          return PostCard(
            post: post,
            onLike: () => profileViewModel.handleLikePost(post),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        isFirstLoading: profileViewModel.loading,
        isLoading: profileViewModel.isLoadMoreLoading,
        error: profileViewModel.error,
        onRetry: profileViewModel.loadMorePosts,
        onLoadMore: profileViewModel.loadMorePosts,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (BuildContext context, ProfileViewModel profileViewModel, Widget? child) {
        return RefreshIndicator(
          onRefresh: () async {
            profileViewModel.cleanPostList();
            profileViewModel.getUserProfile();
            profileViewModel.getMyOwnPost();
          },
          backgroundColor: Colors.white,
          strokeWidth: 2,
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 0;
          },
          child: Skeletonizer(
            enabled: profileViewModel.loading,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildProfileHeader(profileViewModel.user),
                _buildProfileInfo(),
                _buildProfileAchievement(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text('Bài đăng gần đây', style: Theme.of(context).textTheme.titleMedium),
                  ),
                ),
                _buildRecentPost(profileViewModel.postList, profileViewModel.user)
              ],
            ),
          ),
        );
      }
    );
  }
}
