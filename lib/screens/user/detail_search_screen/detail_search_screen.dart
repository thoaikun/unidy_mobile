import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/screens/user/detail_profile/organization_profile/organization_profile_container.dart';
import 'package:unidy_mobile/screens/user/detail_profile/volunteer_profile/volunteer_profile_container.dart';
import 'package:unidy_mobile/viewmodel/user/search_view_model.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';
import 'package:unidy_mobile/widgets/card/organization_card.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';
import 'package:unidy_mobile/widgets/error.dart';

class DetailSearchScreen extends StatefulWidget {
  const DetailSearchScreen({super.key});

  @override
  State<DetailSearchScreen> createState() => _DetailSearchScreenState();
}

class _DetailSearchScreenState extends State<DetailSearchScreen> {
  @override
  Widget build(BuildContext context) {
    ESearchType type = Provider.of<SearchViewModel>(context).type;
    String title = Provider.of<SearchViewModel>(context).title;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: type == ESearchType.post ? const EdgeInsets.all(0) : const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            _buildResults()
          ],
        ),
      )
    );
  }

  Widget _buildResults() {
    SearchViewModel searchViewModel = Provider.of<SearchViewModel>(context);

    if (searchViewModel.isLoading) {
      return SliverFillRemaining(child: const Center(child: CircularProgressIndicator()));
    }
    else if (searchViewModel.error) {
      return SliverFillRemaining(child: ErrorPlaceholder());
    }
    else if (searchViewModel.searchResult != null && searchViewModel.searchResult!.hits.isEmpty) {
      return SliverFillRemaining(child: Empty(description: 'Không tìm thấy kết quả nào'));
    }

    return SliverList.separated(
        itemBuilder: (BuildContext context, int index) {
          dynamic item = searchViewModel.searchResult!.hits[index];
          switch (item.runtimeType) {
            case Friend:
              if (item.role == 'ORGANIZATION') {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OrganizationCard(
                    organization: item,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationProfileContainer(organizationId: item?.userId)))
                  ),
                );
              }
              return FriendCard(
                friend: item,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: item?.userId)))
              );
            case CampaignPost:
              return CampaignPostCard(campaignPost: item);
            case Post:
              return PostCard(post: item);
            default:
              return const SizedBox();
          }
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),
        itemCount: searchViewModel.searchResult!.totals
    );
  }
}
