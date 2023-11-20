import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/user_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final ScrollController _scrollController = ScrollController();

  bool loading = true;
  User _user = User(
    userId: 0,
    fullName: '',
    address: '',
    phone: '',
    sex: '',
    job: '',
    role: '',
    dayOfBirth: DateTime.now(),
    workLocation: '',
  );

  ScrollController get scrollController => _scrollController;
  User get user => _user;

  ProfileViewModel() {
    _scrollController.addListener(onScroll);
    userService.whoAmI()
      .then((user) {
        setUser(user);
        setLoading(false);
      });
  }

  void onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      print('hiii');
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setUser(User value) {
    _user = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}