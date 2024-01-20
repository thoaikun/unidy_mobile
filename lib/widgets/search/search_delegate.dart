import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/themes/color_config.dart';
import 'package:unidy_mobile/config/themes/font_config.dart';
import 'package:unidy_mobile/screens/user/friends_list/request_friends_list_screen.dart';
import 'package:unidy_mobile/utils/font_builder_util.dart';
import 'package:unidy_mobile/widgets/card/friend_card.dart';
import 'package:unidy_mobile/widgets/card/organization_card.dart';
import 'package:unidy_mobile/widgets/card/post_card.dart';

  class UnidySearchDelegate extends SearchDelegate<String> {
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
      return Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                query != '' ? 'Kết quả tìm kiếm cho $query' : '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            _buildOrganizationResult(context),
            _buildUserResult(context),
            _buildPostResult(context)
          ],
        )
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      // Suggested search results as the user types
      final suggestionsList = ['Flutter', 'Dart', 'Widgets', 'Mobile', 'Development'];
  
      final suggestionList = query.isEmpty
          ? suggestionsList
          : suggestionsList.where((word) => word.toLowerCase().startsWith(query.toLowerCase())).toList();
  
      return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index]),
            onTap: () {
              query = suggestionList[index];
              showResults(context);
            },
          );
        },
      );
    }
  
    SliverToBoxAdapter _buildOrganizationResult(BuildContext context) {
      return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestFriendListScreen())),
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
                const Column(
                  children: [
                    OrganizationCard(followed: true),
                    Divider(height: 0.5),
                    OrganizationCard(followed: true),
                    Divider(height: 0.5),
                    OrganizationCard(followed: false),
                  ],
                )
              ],
            ),
          )
      );
    }
  
    SliverToBoxAdapter _buildUserResult(BuildContext context) {
      return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestFriendListScreen())),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Người dùng', style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    AddFriendCard(),
                    Divider(height: 0.5),
                    AddFriendCard(),
                    Divider(height: 0.5),
                    AddFriendCard()
                  ],
                )
              ],
            ),
          )
      );
    }
  
    SliverToBoxAdapter _buildPostResult(BuildContext context) {
      return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestFriendListScreen())),
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
                  children: [
                    const PostCard().searchResult(context),
                    const Divider(height: 0.5),
                    const PostCard().searchResult(context),
                    const Divider(height: 0.5),
                    const PostCard().searchResult(context)
                  ],
                )
              ],
            ),
          )
      );
    }
  }