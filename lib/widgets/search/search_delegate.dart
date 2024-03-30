import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/config/themes/font_config.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/search_result_model.dart';
import 'package:unidy_mobile/screens/user/detail_profile/organization_profile/organization_profile_container.dart';
import 'package:unidy_mobile/screens/user/detail_profile/volunteer_profile/volunteer_profile_container.dart';
import 'package:unidy_mobile/screens/user/detail_search_screen/detail_search_screen.dart';
import 'package:unidy_mobile/screens/user/detail_search_screen/detail_search_screen_container.dart';
import 'package:unidy_mobile/services/search_service.dart';
import 'package:unidy_mobile/utils/font_builder_util.dart';
import 'package:unidy_mobile/viewmodel/user/search_view_model.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';
import 'package:unidy_mobile/widgets/card/organization_card.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';
import 'package:unidy_mobile/widgets/empty.dart';

  class UnidySearchDelegate extends SearchDelegate<String> {
    final SearchService _searchService = GetIt.instance<SearchService>();
    final AppPreferences _appPreferences = GetIt.instance<AppPreferences>();

    @override
    TextStyle get searchFieldStyle => FontBuilder(option: fontRegular).setFontSize(16).setLineHeight(24/16).setLetterSpacing(0.15).font;
  
    @override
    InputDecorationTheme get searchFieldDecorationTheme => const InputDecorationTheme(
      hintStyle: TextStyle(color: TextColor.textColor200),
      border: InputBorder.none,
    );

    @override
    ThemeData appBarTheme(BuildContext context) {
      return Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: TextColor.textColor200),
          border: InputBorder.none,
        )
      );
    }

    @override
    List<Widget>? buildActions(BuildContext context) {
      return [
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: const Icon(Icons.clear, size: 20)
        )
      ];
    }
  
    @override
    Widget? buildLeading(BuildContext context) {
      return IconButton(
        onPressed: () => close(context, ''),
        icon: const Icon(Icons.arrow_back_ios_rounded, size: 20)
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      _saveToHistory(query).then((_) => {});

      return FutureBuilder(
        future: _searchService.search(query, offset: 0, limit: 3),
        builder: (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Empty(
                description: 'Không tìm thấy kết quả phù hợp',
              ),
            );
          }

          List<dynamic> posts = [];
          List<Friend> users = [];
          List<Friend> organizations = [];

          for (var item in snapshot.data!.hits) {
            if (item is Post || item is CampaignPost) {
              posts.add(item);
            }
            else if (item is Friend) {
              if (item.role == 'ORGANIZATION') {
                organizations.add(item);
              }
              else {
                users.add(item);
              }
            }
          }

          return Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      query != '' ? 'Kết quả tìm kiếm cho: $query' : '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                _buildOrganizationResult(context, organizations),
                _buildUserResult(context, users),
                _buildPostResult(context, posts)
              ],
            )
          );
        }
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      List<dynamic> histories = _getSearchHistory();
      List<dynamic> suggestions = histories.where((element) => element?.contains(query.toLowerCase())).toList();

      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index], style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: TextColor.textColor500)),
            leading: const Icon(Icons.history, size: 18, color: TextColor.textColor500),
            onTap: () {
              query = suggestions[index];
              showResults(context);
            },
          );
        },
      );

    }
  
    SliverToBoxAdapter _buildOrganizationResult(BuildContext context, List<Friend> organizations) {
      List<Widget> organizationWidgets = [];
      for (int i = 0; i < organizations.length; i++) {
        Friend organization = organizations[i];
        organizationWidgets.add(
            OrganizationCard(
              organization: organization,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrganizationProfileContainer(organizationId: organization.userId)))
            )
        );
        if (i != organizations.length - 1) {
          organizationWidgets.add(const Divider(height: 0.5));
        }
      }

      return SliverToBoxAdapter(
          child: Visibility(
            visible: organizations.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSearchScreenContainer(query: query, type: ESearchType.organization))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Tổ chức', style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: organizationWidgets,
                  )
                ],
              ),
            ),
          )
      );
    }
  
    SliverToBoxAdapter _buildUserResult(BuildContext context, List<Friend> users) {
      List<Widget> userWidgets = [];
      for (int i = 0; i < users.length; i++) {
        Friend user = users[i];
        userWidgets.add(
          FriendCard(
            friend: user,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerProfileContainer(volunteerId: user.userId)))
          )
        );
        if (i != users.length - 1) {
          userWidgets.add(const Divider(height: 0.5));
        }
      }

      return SliverToBoxAdapter(
          child: Visibility(
            visible: users.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSearchScreenContainer(query: query, type: ESearchType.user))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Người dùng', style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(width: 5),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                      ],
                    ),
                  ),
                  Column(
                    children: userWidgets,
                  )
                ],
              ),
            ),
          )
      );
    }
  
    SliverToBoxAdapter _buildPostResult(BuildContext context, List<dynamic> posts) {
      List<Widget> postWidgets = [];
      for (int i = 0; i < posts.length; i++) {
        if (posts[i] is CampaignPost) {
          CampaignPost campaign = posts[i];
          postWidgets.add(CampaignPostCard(campaignPost: campaign));
        }
        else {
          Post post = posts[i];
          postWidgets.add(PostCard(post: post));
        }
        if (i != posts.length - 1) {
          postWidgets.add(const Divider(height: 0.5));
        }
      }

      return SliverToBoxAdapter(
          child: Visibility(
            visible: posts.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSearchScreenContainer(query: query, type: ESearchType.post))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Bài đăng', style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: postWidgets,
                  )
                ],
              ),
            ),
          )
      );
    }

    List<dynamic> _getSearchHistory() {
      String? value = _appPreferences.getString('searchHistory');
      if (value != null) {
        List<dynamic> histories = jsonDecode(value);
        return histories;
      }
      return [];
    }

    Future<void> _saveToHistory(String keyword) async {
      List<dynamic> histories = _getSearchHistory();
      if (keyword == '' || histories.contains(keyword)) return;
      histories.add(keyword);
      await _appPreferences.setString('searchHistory', jsonEncode(histories));
    }
  }