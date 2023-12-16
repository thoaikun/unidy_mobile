import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/user_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService userService = GetIt.instance<UserService>();
  final PostService postService = GetIt.instance<PostService>();
  final ScrollController _scrollController = ScrollController();

  bool loading = true;
  User _user = User(
    userId: 0,
    fullName: 'Không rõ',
    address: 'Không rõ',
    phone: '',
    sex: '',
    job: '',
    role: '',
    dayOfBirth: DateTime.now(),
    workLocation: ''
  );
  List<Post> _postList = [];

  ScrollController get scrollController => _scrollController;
  User get user => _user;
  List<Post> get postList => _postList;

  ProfileViewModel() {
    initData();
    _scrollController.addListener(onScroll);
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

  void setPostList(List<Post> value) {
    _postList = value;
    notifyListeners();
  }

  void initData() {
    userService.whoAmI()
      .then((user) {
        setUser(user);
        return postService.getUserPosts(user.userId);
      })
      .then((postList) {
        setPostList(postList);
        setLoading(false);
      })
      .catchError((error) {
        print(error);
        setLoading(false);
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}