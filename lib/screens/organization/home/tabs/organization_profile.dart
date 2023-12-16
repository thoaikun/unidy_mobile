import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
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
                        fit: BoxFit.cover,
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
                        child: const CircleAvatar(
                          radius: 120,
                          backgroundImage: NetworkImage(
                            'https://api.dicebear.com/7.x/initials/png?seed=unknown',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 15, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Unknown',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 5)
                    ],
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
