import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/viewmodel/profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/profile/profile_archievement.dart';
import 'package:unidy_mobile/widgets/profile/profile_header.dart';
import 'package:unidy_mobile/widgets/profile/profile_info.dart';
import 'package:unidy_mobile/widgets/profile/profile_recent_post.dart';

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
        print('hihihihi');
      }
    });
  }
  
  SliverToBoxAdapter _buildProfileHeader() {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          ProfileHeader(),
          Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      )
    );
  }

  SliverToBoxAdapter _buildProfileInfo() {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          ProfileInfo(),
          Divider(thickness: 5, color: PrimaryColor.primary50)
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (BuildContext context, ProfileViewModel profileViewModel, Widget? child) {
        return CustomScrollView(
          controller: profileViewModel.scrollController,
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
            const ProfileRecentPost()
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
