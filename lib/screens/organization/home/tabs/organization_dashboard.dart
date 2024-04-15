import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/organization_profile_cubit.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';
import 'package:unidy_mobile/viewmodel/organization/home/organization_dashboard_viewmodel.dart';
import 'package:unidy_mobile/widgets/card/organization_campaign_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';

import '../../../../viewmodel/organization/home/organization_profile_viewmodel.dart';

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
    _tabController.addListener(() {
      context.read<OrganizationDashboardViewModel>().changeTab(_tabController.index);
    });
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
    OrganizationDashboardViewModel viewModel = Provider.of<OrganizationDashboardViewModel>(context);
    List<Campaign> newestCampaign = viewModel.newestCampaign;

    if (viewModel.isCampaignLoading) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          height: 400,
          child: Center(child: CircularProgressIndicator())
        )
      );
    }
    else if (newestCampaign.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox());
    }

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
              items: newestCampaign.map((item) => OrganizationCampaignCard(campaign: item)).toList(),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 5, color: PrimaryColor.primary50)
          ],
        ),
      )
    );
  }

  SliverToBoxAdapter _buildOrganizationGeneralInfo() {
    Organization organization = Provider.of<OrganizationProfileViewModel>(context).organization;

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
                          'assets/imgs/icon/campaign.png',
                          width: 45,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '${organization.overallFigure?.totalCampaign ?? 0} chiến dịch',
                          style: Theme.of(context).textTheme.titleMedium
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Số lượng chiến dịch',
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
                            '${organization.overallFigure?.totalVolunteer ?? 0} người',
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
                            Formatter.formatCurrency(organization.overallFigure?.totalTransactionInDay ?? 0),
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
                            Formatter.formatCurrency(organization.overallFigure?.totalTransaction ?? 0),
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
            _buildNewestDonationList(),
            // Content for Tab 2
            _buildTopDonationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewestDonationList() {
    OrganizationDashboardViewModel viewModel = Provider.of<OrganizationDashboardViewModel>(context);
    List<DonationHistory> newestDonations = viewModel.newestDonations;

    if (viewModel.isNewestLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (newestDonations.isEmpty) {
      return const Empty(description: 'Chưa có dữ liệu');
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newestDonations.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        leading: CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(
            newestDonations[index].user.linkImage ?? 'https://api.dicebear.com/7.x/initials/png?seed=${newestDonations[index].user.fullName}',
          ),
        ),
        title: Text(newestDonations[index].user.fullName, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Text(Formatter.formatCurrency(newestDonations[index].transactionAmount), style: Theme.of(context).textTheme.bodyMedium),
      ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildTopDonationList() {
    OrganizationDashboardViewModel viewModel = Provider.of<OrganizationDashboardViewModel>(context);
    List<DonationHistory> topDonations = viewModel.topDonations;

    if (viewModel.isTopLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    else if (topDonations.isEmpty) {
      return const Empty(description: 'Chưa có dữ liệu');
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: topDonations.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        leading: CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(
            topDonations[index].user.linkImage ?? 'https://api.dicebear.com/7.x/initials/png?seed=${topDonations[index].user.fullName}',
          ),
        ),
        title: Text(topDonations[index].user.fullName, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Text(Formatter.formatCurrency(topDonations[index].transactionAmount), style: Theme.of(context).textTheme.bodyMedium),
      ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
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
