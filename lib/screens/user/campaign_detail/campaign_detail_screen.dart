import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/user/detail_campaign_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/campaign_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/error.dart';
import 'package:unidy_mobile/widgets/image/image_slider.dart';
import 'package:unidy_mobile/widgets/loadmore_indicator.dart';
import 'package:unidy_mobile/widgets/progress_bar/circle_progress_bar.dart';
import 'package:unidy_mobile/widgets/status_tag.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CampaignDetailScreen extends StatefulWidget {
  final Campaign? campaign;
  const CampaignDetailScreen({super.key, required this.campaign});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    DetailCampaignViewModel detailCampaignViewModel = Provider.of<DetailCampaignViewModel>(context, listen: false);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        detailCampaignViewModel.changeTab(EDetailCampaignTab.certificate);
      }
      else {
        detailCampaignViewModel.changeTab(EDetailCampaignTab.report);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.campaign?.title ?? 'Chiến dịch chưa có tên'),
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
              children: [
                // Content for Tab 1
                _buildCertificateTab(),
                // Content for Tab 2
                _buildDonationTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildImageSlider() {
    List<dynamic> imageUrls = [];
    if (widget.campaign?.linkImage == null || widget.campaign?.linkImage == "") {
      return const SliverToBoxAdapter(child: SizedBox(height: 0,));
    }

    imageUrls = List<String>.from(jsonDecode(widget.campaign?.linkImage ?? '[]'));
    List<String> result = [];
    for (String image in imageUrls) {
      result.add(image);
    }
    return SliverToBoxAdapter(
      child: ImageSlider(imageUrls: result)
    );
  }

  SliverToBoxAdapter _buildCampaignInfo() {
    Widget status = const StatusTag(label: 'Đã kết thúc', type: StatusType.success);
    if (widget.campaign?.status == CampaignStatus.inProgress) {
      status = const StatusTag(label: 'Đang diễn ra', type: StatusType.info);
    }
    else if (widget.campaign?.status == CampaignStatus.canceled) {
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
                    widget.campaign?.title ?? 'Chiến dịch chưa có tên',
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
                        widget.campaign?.timeTakePlace ?? '',
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
                        widget.campaign?.location ?? 'Không có địa điểm',
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
                    widget.campaign?.description ?? '',
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Đọc thêm',
                    trimExpandedText: '',
                    moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300),
                  ),
                ),
                Text(
                  widget.campaign?.hashTag ?? '',
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
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleProgressBar(
                  max: widget.campaign?.donationBudget ?? 100,
                  value: widget.campaign?.donationBudgetReceived ?? 0,
                  radius: 180,
                  label: Formatter.formatCurrency(widget.campaign?.donationBudgetReceived ?? 0),
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
                  max: widget.campaign?.numberVolunteer ?? 100,
                  value: widget.campaign?.numberVolunteer ?? 0,
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
        labelColor: PrimaryColor.primary500,
        unselectedLabelColor: TextColor.textColor300,
        tabs: const <Widget>[
          Tab(text: 'Chứng nhận'),
          Tab(text: 'Báo cáo chiến dịch'),
        ],
      ),
    );
  }

  Widget _buildCertificateTab() {
    DetailCampaignViewModel detailCampaignViewModel = Provider.of<DetailCampaignViewModel>(context);

    if (detailCampaignViewModel.isCertificateLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (detailCampaignViewModel.certificate == null) {
      return const Empty(description: 'Chưa có chứng nhận');
    }
    else if (detailCampaignViewModel.certificateError) {
      return ErrorPlaceholder(
        onRetry: () {
          detailCampaignViewModel.initData();
        },
      );
    }

    WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(detailCampaignViewModel.certificate?.certificateLink ?? ''))
      ..setUserAgent('Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.96 Mobile Safari/537.36');

    return WebViewWidget(controller: controller);
  }

  Widget _buildDonationTab() {
    DetailCampaignViewModel detailCampaignViewModel = Provider.of<DetailCampaignViewModel>(context);

    if (detailCampaignViewModel.isDonationLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (detailCampaignViewModel.donations.isEmpty) {
      return const Empty(description: 'Chưa có thông tin ủng hộ');
    }
    else if (detailCampaignViewModel.reportError) {
      return ErrorPlaceholder(
        onRetry: () {
          detailCampaignViewModel.initData();
        },
      );
    }

    return ListView.builder(
      itemCount: detailCampaignViewModel.donations.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < detailCampaignViewModel.donations.length) {
          return _buildDonationCard(detailCampaignViewModel.donations[index]);
        }
        else if (index == detailCampaignViewModel.donations.length) {
          return TextButton(
            onPressed: () {
              detailCampaignViewModel.loadMoreDonations();
            },
            child: const Text('Xem thêm'),
          );
        }
      },
    );
  }

  Widget _buildDonationCard(DonationHistory donation) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(donation.user.linkImage ?? ''),
      ),
      title: Text(donation.user.fullName ?? ''),
      subtitle: Text('Đã ủng hộ ${Formatter.formatCurrency(donation.transactionAmount)}'),
    );
  }
}
