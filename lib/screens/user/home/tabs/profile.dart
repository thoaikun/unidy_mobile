import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/profile_header.dart';
import 'package:unidy_mobile/widgets/profile_info.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildProfileHeader(),
        _buildProfileInfo()
      ],
    );
  }
}
