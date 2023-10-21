import 'package:flutter/material.dart';
import 'package:unidy_mobile/config/color_config.dart';
import 'package:unidy_mobile/config/font_config.dart';
import 'package:unidy_mobile/utils/utils_font._builder.dart';

class UnidySearchDelegate extends SearchDelegate<String> {
  @override
  TextStyle get searchFieldStyle => FontBuilder(option: fontRegular).setFontSize(16).setLineHeight(24/16).setLetterSpacing(0.15).font;

  @override
  InputDecorationTheme get searchFieldDecorationTheme => const InputDecorationTheme(
    hintStyle: TextStyle(color: TextColor.textColor200),
    border: InputBorder.none,
  );

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
      child: Column(
        children: [
          Text(
            query != '' ? 'Kết quả tìm kiếm cho $query' : '',
          ),
          const SizedBox(height: 20),
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

}