import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/profile/profile_header.dart';
import 'package:unidy_mobile/widgets/profile/profile_organization_info.dart';

class OrganizationProfile extends StatefulWidget {
  const OrganizationProfile({super.key});

  @override
  State<OrganizationProfile> createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildProfileHeader(),
        _buildProfileInfo(),
        _buildProfileActivity()
      ],
    );
  }

  SliverToBoxAdapter _buildProfileHeader() {
    return const SliverToBoxAdapter(
        child: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: 20),
            Divider(thickness: 5, color: PrimaryColor.primary50)
          ],
        )
    );
  }

  SliverToBoxAdapter _buildProfileInfo() {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          ProfileOrganizationInfo(),
          Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildProfileActivity() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng quan hoạt động',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Số người theo dõi: ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  '20 triệu',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text('Số hoạt động đã tổ chức:  ', style: Theme.of(context).textTheme.labelLarge,),
                Text('30', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
              ],
            ),
          ]
        )
      )
    );
  }
}
