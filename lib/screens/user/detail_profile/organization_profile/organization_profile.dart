import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/user/other_profile_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/error.dart';

import '../../../../widgets/list_item.dart';

class OrganizationProfileScreen extends StatefulWidget {
  const OrganizationProfileScreen({super.key});

  @override
  State<OrganizationProfileScreen> createState() => _OrganizationProfileScreenState();
}

class _OrganizationProfileScreenState extends State<OrganizationProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        Provider.of<OrganizationProfileViewModel>(context, listen: false).loadMoreData();
      }
    });
  }

  SliverToBoxAdapter _buildProfileHeader() {
    OrganizationProfileViewModel organizationProfileViewModel = Provider.of<OrganizationProfileViewModel>(context);
    Organization? organization = organizationProfileViewModel.organization;

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
                            organization?.image ?? 'https://api.dicebear.com/7.x/initials/png?seed=${organization?.organizationName ?? ''}',
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
                            organization?.organizationName ?? 'Không rõ',
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
                        child: organization?.isFollow == true ?
                        FilledButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.track_changes_sharp, size: 20),
                            label: Text('Đang theo dõi')
                        ) :
                        OutlinedButton.icon(
                            onPressed: () => organizationProfileViewModel.onFollow(),
                            icon: Icon(Icons.add_outlined, size: 20),
                            label: Text('Theo dõi')
                        ),
                      )
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
    Organization? organization = Provider.of<OrganizationProfileViewModel>(context).organization;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Thông tin tổ chức',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Ngày thành lập: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      Formatter.formatTime(DateTime.now(), 'dd/MM/yyyy - HH:mm').toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Trụ sở chính: ', style: Theme.of(context).textTheme.labelLarge,),
                    Text(organization?.country ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Số điện thoại: ', style: Theme.of(context).textTheme.labelLarge,),
                    Text(organization?.phone ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('Email: ', style: Theme.of(context).textTheme.labelLarge,),
                    Text(organization?.email ?? 'Không rõ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),)
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 5, color: PrimaryColor.primary50)
        ],
      ),
    );
  }

  Widget _buildRecentPost() {
    OrganizationProfileViewModel organizationProfileViewModel = Provider.of<OrganizationProfileViewModel>(context);
    List<CampaignPost> campaigns = organizationProfileViewModel.campaigns;

    if (campaigns.isEmpty) {
      return const SliverToBoxAdapter(
        child: Empty(description: 'Chưa có chiến dịch nào')
      );
    }

    return SliverListItem<CampaignPost>(
      items: campaigns,
      length: campaigns.length,
      itemBuilder: (BuildContext context, int index) {
        CampaignPost campaign = campaigns[index];
        return CampaignPostCard(
          campaignPost: campaign,
          onLike: () => Provider.of<OrganizationProfileViewModel>(context, listen: false).handleLikeCampaign(campaign),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
      isFirstLoading: organizationProfileViewModel.isLoading,
      isLoading: organizationProfileViewModel.isLoadingMore,
      error: organizationProfileViewModel.error,
      onRetry: organizationProfileViewModel.loadMoreData,
      onLoadMore: organizationProfileViewModel.loadMoreData
    );
  }

  @override
  Widget build(BuildContext context) {
    OrganizationProfileViewModel organizationProfileViewModel = Provider.of<OrganizationProfileViewModel>(context);
    if (organizationProfileViewModel.error) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin tổ chức'),
        ),
        body: ErrorPlaceholder(
            onRetry: () => organizationProfileViewModel.refreshData()
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tổ chức'),
      ),
      body: Skeletonizer(
        enabled: organizationProfileViewModel.isLoading,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildProfileHeader(),
            _buildProfileInfo(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Text('Chiến dịch gần đây', style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
            _buildRecentPost()
          ],
        ),
      ),
    );
  }
}
