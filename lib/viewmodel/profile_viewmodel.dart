import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  ProfileViewModel() {
    _scrollController.addListener(onScroll);
  }

  void onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      print('hiii');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}