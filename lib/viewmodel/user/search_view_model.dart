import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/models/search_result_model.dart';
import 'package:unidy_mobile/services/search_service.dart';

enum ESearchType {
  post,
  organization,
  user
}

class SearchViewModel extends ChangeNotifier {
  final SearchService _searchService = GetIt.instance<SearchService>();

  final int LIMIT = 10;
  String query;
  ESearchType type;
  String title = '';
  bool isLoading = false;
  bool error = false;
  int _offset = 0;

  SearchResult? _searchResult;
  SearchResult? get searchResult => _searchResult;

  SearchViewModel({required this.query, required this.type}) {
    switch(type) {
      case ESearchType.post:
        title = 'Bài đăng với từ khóa: $query';
        break;
      case ESearchType.organization:
        title = 'Tổ chức với từ khóa: $query';
        break;
      case ESearchType.user:
        title = 'Người dùng với từ khóa: $query';
        break;
    }
    onSearch();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void setSearchResult(SearchResult value) {
    _searchResult = value;
    notifyListeners();
  }

  void onSearch() {
    setLoading(true);
    switch(type) {
      case ESearchType.post:
        _searchService.searchPost(query, offset: _offset, limit: LIMIT)
          .then((value) {
            setSearchResult(value);
          })
          .catchError((error) {
            setError(true);
          })
          .whenComplete(() {
            setLoading(false);
          });
        break;
      case ESearchType.organization:
        _searchService.search(query, offset: _offset, limit: LIMIT)
          .then((value) {
            setSearchResult(value);
          })
          .catchError((error) {
            setError(true);
          })
          .whenComplete(() {
            setLoading(false);
          });
        break;
      case ESearchType.user:
        _searchService.searchUser(query, offset: _offset, limit: LIMIT)
          .then((value) {
            setSearchResult(value);
          })
          .catchError((error) {
            setError(true);
          })
          .whenComplete(() {
            setLoading(false);
          });
        break;
    }
  }
}