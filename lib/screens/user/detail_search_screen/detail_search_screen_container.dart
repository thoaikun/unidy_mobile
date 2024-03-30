import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/viewmodel/user/search_view_model.dart';

import 'detail_search_screen.dart';

class DetailSearchScreenContainer extends StatefulWidget {
  final String query;
  final ESearchType type;
  const DetailSearchScreenContainer({super.key, required this.query, required this.type});

  @override
  State<DetailSearchScreenContainer> createState() => _DetailSearchScreenContainerState();
}

class _DetailSearchScreenContainerState extends State<DetailSearchScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SearchViewModel(query: widget.query, type: widget.type),
      child: const DetailSearchScreen(),
    );
  }
}
