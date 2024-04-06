import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/screens/organization/edit_campaign/edit_campaign_screen_container.dart';
import 'package:unidy_mobile/screens/organization/organization_campaign_detail/tabs/sponsor_donation.dart';
import 'package:unidy_mobile/screens/organization/organization_campaign_detail/tabs/volunteer_accepted.dart';
import 'package:unidy_mobile/screens/organization/organization_campaign_detail/tabs/volunteer_request.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/organization/organization_campaign_detail_viewmodel.dart';
import 'package:unidy_mobile/widgets/image/image_slider.dart';
import 'package:unidy_mobile/widgets/input/input.dart';
import 'package:unidy_mobile/widgets/progress_bar/circle_progress_bar.dart';
import 'package:unidy_mobile/widgets/status_tag.dart';

class OrganizationCampaignDetailScreen extends StatefulWidget {
  const OrganizationCampaignDetailScreen({super.key});

  @override
  State<OrganizationCampaignDetailScreen> createState() => _OrganizationCampaignDetailScreenState();
}

class _OrganizationCampaignDetailScreenState extends State<OrganizationCampaignDetailScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.campaign.title ?? 'Chiến dịch'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditCampaignScreenContainer(
                  campaign: viewModel.campaign,
                  onUpdateCampaign: viewModel.setCampaign
                ))
            ),
            icon: const Icon(Icons.edit_rounded)
          ),
          IconButton(
            onPressed: viewModel.campaign.status == CampaignStatus.inProgress
                ? () => _showCompleteCampaignDialog(viewModel.onEndCampaign)
                : null,
            icon: const Icon(Icons.fact_check_rounded),
            disabledColor: TextColor.textColor200,
            color: PrimaryColor.primary500,
          )
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: Visibility(
              visible: Provider.of<OrganizationCampaignDetailViewModel>(context).updateLoading,
              child: const LinearProgressIndicator(),
            ),
        )
      ),
      body: CustomScrollView(
        slivers: [
          _buildImageSlider(),
          _buildCampaignInfo(),
          _buildProgressInfo(),
          _buildCampaignTabs(),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: const [
                VolunteerRequest(),
                VolunteerAccepted(),
                SponsorDonation(),
                Center(child: Text('Tab 4 Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildImageSlider() {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context);
    List<dynamic> imageUrls = [];
    if (viewModel.campaign.linkImage == null || viewModel.campaign.linkImage == "") {
      return const SliverToBoxAdapter(child: SizedBox(height: 0,));
    }

    imageUrls = List<String>.from(jsonDecode(viewModel.campaign.linkImage ?? '[]'));
    List<String> result = [];
    for (String image in imageUrls) {
      result.add(image);
    }

    return SliverToBoxAdapter(
      child: ImageSlider(imageUrls: result)
    );
  }

  SliverToBoxAdapter _buildCampaignInfo() {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context);

    Widget status = const StatusTag(label: 'Đã kết thúc', type: StatusType.success);
    if (viewModel.campaign.status == CampaignStatus.inProgress) {
      status = const StatusTag(label: 'Đang diễn ra', type: StatusType.info);
    }
    else if (viewModel.campaign.status == CampaignStatus.canceled) {
      status = const StatusTag(label: 'Đã hủy', type: StatusType.error);
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.start,
          runSpacing: 14,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    viewModel.campaign.title ?? 'Không rõ',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ),
                const SizedBox(width: 15),
                status
              ],
            ),
            Wrap(
              runSpacing: 8,
              children: [
                Row(
                  children: [
                    const Text('Thời gian diễn ra: '),
                    Expanded(
                      child: Text(
                        viewModel.campaign.timeTakePlace ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                      )
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text('Địa điểm diễn ra: '),
                    Expanded(
                      child: Text(
                        viewModel.campaign.location,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor300),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 5,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReadMoreText(
                    viewModel.campaign.description ?? '',
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Đọc thêm',
                    trimExpandedText: '',
                    moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300),
                  ),
                ),
                Text(
                  viewModel.campaign.hashTag ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: PrimaryColor.primary500),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildProgressInfo() {
    OrganizationCampaignDetailViewModel viewModel = Provider.of<OrganizationCampaignDetailViewModel>(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleProgressBar(
                  max: viewModel.campaign.donationBudget ?? 100,
                  value: viewModel.campaign.donationBudgetReceived ?? 0,
                  radius: 180,
                  label: Formatter.formatCurrency(viewModel.campaign.donationBudgetReceived ?? 0),
                  backgroundColor: SuccessColor.success200,
                  color: SuccessColor.success500,
                ),
                const SizedBox(height: 20),
                Text(
                  'Số tiền đã ủng hộ',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            Column(
              children: [
                CircleProgressBar(
                  max: viewModel.campaign.numberVolunteer ?? 100,
                  value: viewModel.campaign.numberVolunteerRegistered ?? 0,
                  radius: 80,
                  backgroundColor: PrimaryColor.primary200,
                  color: PrimaryColor.primary500,
                ),
                const SizedBox(height: 20),
                Text(
                  'Số người tham gia',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildCampaignTabs() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: null,
      automaticallyImplyLeading: false,
      title: TabBar.secondary(
        controller: _tabController,
        isScrollable: true,
        labelColor: PrimaryColor.primary500,
        unselectedLabelColor: TextColor.textColor300,
        tabs: const <Widget>[
          Tab(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text('Yêu cầu tham gia'),
            )
          ),
          Tab(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text('Người tham gia'),
              )
          ),
          Tab(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text('Nhà hảo tâm'),
              )
          ),
          Tab(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text('Các khoảng chi'),
              )
          ),
        ],
      ),
    );
  }

  Future<void> _showCompleteCampaignDialog(void Function() onEndCampaign) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: const Text('Kết thúc sự kiện'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bạn có chắc chắn muốn kết thúc chiến dịch. Thông tin chiến dịch và bằng khen sẽ được gửi '
                  'tới những người tham gia.')
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () {
                onEndCampaign();
                Navigator.of(context).pop();
              },
              child: const Text('Đồng ý'),
            )
          ],
        );
      },
    );
  }
}


