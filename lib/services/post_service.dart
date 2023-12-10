import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class PostService {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<List<Post>> getUserPosts(int userId) async {
    try {
      Response response = await httpClient.get('api/v1/posts/get-post-by-userId?userId=$userId');

      switch(response.statusCode) {
        case 200:
          List<Post> postListResponse = postListFromJson(utf8.decode(response.bodyBytes));
          return postListResponse;
        case 400:
          throw ResponseException(value: 'UserId không đúng', code: ExceptionErrorCode.invalidUserId);
        case 403:
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<List<Post>> getRecommendationPosts() async {
    try {
      Response response = await httpClient.get('api/v1/posts');

      switch(response.statusCode) {
        case 200:
          List<Post> postListResponse = postListFromJson(utf8.decode(response.bodyBytes));
          return postListResponse;
        case 403:
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<void> create() {
    throw UnimplementedError();
  }

  Future<void> update() {
    throw UnimplementedError();
  }

  Future<void> delete() {
    throw UnimplementedError();
  }
}