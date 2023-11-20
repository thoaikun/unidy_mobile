import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/widgets/card/organization_campaign_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildRecentCampaign(),
        _buildOrganizationGeneralInfo(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
            child: Text('Nhà hảo tâm', style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
        _buildDonationTabs(),
        _buildTopDonationDashboard(),
      ],
    );
  }

  SliverToBoxAdapter _buildRecentCampaign() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Hoạt động gần đây', style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                viewportFraction: 0.9,
                enlargeCenterPage: false,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enableInfiniteScroll: false
              ),
              items: const [
                OrganizationCampaignCard(),
                OrganizationCampaignCard(),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 5, color: PrimaryColor.primary50)
          ],
        ),
      )
    );
  }

  SliverToBoxAdapter _buildOrganizationGeneralInfo() {
    double size = MediaQuery.of(context).size.width - 40 - 10 / 2;
    BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: TextColor.textColor200, width: 1),
    );

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text('Tổng quan tổ chức', style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  Container(
                    width: size,
                    height: size,
                    decoration: decoration,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/imgs/icon/role_sponsor_unselected.png',
                          width: 45,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '500 triệu đồng',
                          style: Theme.of(context).textTheme.titleMedium
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Tổng tiền nhận được',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.textColor300)
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size,
                    height: size,
                    decoration: decoration,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/imgs/icon/people.png',
                          width: 45,
                        ),
                        const SizedBox(height: 15),
                        Text(
                            '200 người',
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                        const SizedBox(height: 5),
                        Text(
                            'Tình nguyện viên',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.textColor300)
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size,
                    height: size,
                    decoration: decoration,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/imgs/icon/calendar.png',
                          width: 45,
                        ),
                        const SizedBox(height: 15),
                        Text(
                            '500 triệu đồng',
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                        const SizedBox(height: 5),
                        Text(
                            'Nhận được hôm nay',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.textColor300)
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: size,
                    height: size,
                    decoration: decoration,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/imgs/icon/role_sponsor_unselected.png',
                          width: 45,
                        ),
                        const SizedBox(height: 15),
                        Text(
                            '500 triệu đồng',
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                        const SizedBox(height: 5),
                        Text(
                            'Tổng tiền nhận được',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TextColor.textColor300)
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 5, color: PrimaryColor.primary50)
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTopDonationDashboard() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 380,
        child: TabBarView(
          controller: _tabController,
          children: [
            // Content for Tab 1
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) => ListTile(
                leading: const CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
                  ),
                ),
                title: const Text('Thái Lê'),
                trailing: Text('140 triệu', style: Theme.of(context).textTheme.bodyMedium),
              ),
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
            // Content for Tab 2
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) => ListTile(
                leading: const CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?s=612x612&w=0&k=20&c=JSBpwVFm8vz23PZ44Rjn728NwmMtBa_DYL7qxrEWr38=',
                  ),
                ),
                title: const Text('Johnny Nguyễn'),
                trailing: Text('340 triệu', style: Theme.of(context).textTheme.bodyMedium),
              ),
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildDonationTabs() {
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
          Tab(text: 'Gần đây'),
          Tab(text: 'Top ủng hộ'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
