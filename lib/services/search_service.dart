import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/search_result_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class SearchService extends Service {
  final HttpClient _httpClient = GetIt.instance.get<HttpClient>();

  Future<SearchResult> search(String query, {int offset = 0, int limit = 5}) async {
    try {
      Map<String, dynamic> payload = {
        'searchTerm': query,
        'offset': offset.toString(),
        'limit': limit.toString(),
      };
      final response = await _httpClient.get('api/v1/search', payload);
      switch(response.statusCode) {
        case 200:
          return searchResultFromJson(utf8.decode(response.bodyBytes));
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<SearchResult> searchCampaign(String query, {int offset = 0, int limit = 5}) async {
    try {
      Map<String, dynamic> payload = {
        'query': query,
        'offset': offset.toString(),
        'limit': limit.toString(),
      };
      final response = await _httpClient.get('api/v1/search/campaign', payload);
      switch(response.statusCode) {
        case 200:
          return searchResultFromJson(utf8.decode(response.bodyBytes));
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<SearchResult> searchPost(String query, {int offset = 0, int limit = 5}) async {
    try {
      Map<String, dynamic> payload = {
        'query': query,
        'offset': offset.toString(),
        'limit': limit.toString(),
      };
      final response = await _httpClient.get('api/v1/search/post', payload);
      switch(response.statusCode) {
        case 200:
          return searchResultFromJson(utf8.decode(response.bodyBytes));
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<SearchResult> searchUser(String query, {int offset = 0, int limit = 5}) async {
    try {
      Map<String, dynamic> payload = {
        'query': query,
        'offset': offset.toString(),
        'limit': limit.toString(),
      };
      final response = await _httpClient.get('api/v1/search/user', payload);
      switch(response.statusCode) {
        case 200:
          return searchResultFromJson(utf8.decode(response.bodyBytes));
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }
}