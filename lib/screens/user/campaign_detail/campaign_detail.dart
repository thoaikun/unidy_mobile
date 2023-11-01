import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/image/image_slider.dart';
import 'package:unidy_mobile/widgets/progress_bar/circle_progress_bar.dart';
import 'package:unidy_mobile/widgets/status_tag.dart';

class CampaignDetailScreen extends StatefulWidget {
  const CampaignDetailScreen({super.key});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Tên hoạt động'),
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
                // Content for Tab 1
                Center(child: Text('Tab 1 Content')),
                // Content for Tab 2
                Center(child: Text('Tab 2 Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildImageSlider() {
    return const SliverToBoxAdapter(
      child: ImageSlider(imageUrls: [
        'https://upload.wikimedia.org/wikipedia/commons/6/6c/Vilnius_Marathon_2015_volunteers_by_Augustas_Didzgalvis.jpg',
        'https://kindful.com/wp-content/uploads/volunteer-management_Feature.jpg',
        'https://images.ctfassets.net/81iqaqpfd8fy/57NATA4649mbTvRfGpd6R1/911f94cdfd6089a77aefb4b1e9ebac7a/Teenvolunteercover.jpg'
      ])
    );
  }

  SliverToBoxAdapter _buildCampaignInfo() {
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
                    'Vẫn là tên của chiến dịch ở đây chứ khong di day xa cả',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ),
                const SizedBox(width: 15),
                const StatusTag(label: 'Đã kết thúc')
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
                        '20/3/2023 - 23/12/2023',
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
                        'Sở thú thành phố Hồ Chí Minh',
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
                ReadMoreText(
                  'Cake or pie? I can tell a lot about you by which one you pick. It may seem silly, but cake people and pie people are really different. I know which one I hope you are, but that\'s not for me to decide. So, what is it? Cake or pie? ',
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Đọc thêm',
                  trimExpandedText: '',
                  moreStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: TextColor.textColor300),
                ),
                Text(
                  '#dieforone #gogo',
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
                const CircleProgressBar(
                  max: 100,
                  value: 70,
                  radius: 100,
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
                const CircleProgressBar(
                  max: 100,
                  value: 70,
                  radius: 100,
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
}
