import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/comment_model.dart';
import 'package:unidy_mobile/models/post_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class PostService extends Service {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<List<Post>> getUserPosts(int userId, {int skip = 0, int limit = 5}) async {
    Map<String, dynamic> payload = {
      'skip': skip.toString(),
      'limit': limit.toString()
    };

    try {
      Response response = await httpClient.get('api/v1/posts/users/$userId', payload);

      switch(response.statusCode) {
        case 200:
          List<Post> postListResponse = postListFromJson(utf8.decode(response.bodyBytes));
          return postListResponse;
        case 400:
          throw ResponseException(value: 'UserId không đúng', code: ExceptionErrorCode.invalidUserId);
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

  Future<List<Post>> getRecommendationPosts({int skip = 0, int limit = 5}) async {
    Map<String, dynamic> payload = {
      'skip': skip.toString(),
      'limit': limit.toString()
    };

    try {
      Response response = await httpClient.get('api/v1/posts', payload);

      switch(response.statusCode) {
        case 200:
          List<Post> postListResponse = postListFromJson(utf8.decode(response.bodyBytes));
          return postListResponse;
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

  Future<void> create(Map<String, String> payload, List<MultipartFile> files) async {
    try {
      StreamedResponse streamedResponse = await httpClient.uploadImage('api/v1/posts', files, payload);
      Response response = await Response.fromStream(streamedResponse);

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Định dạng ảnh không phù hợp', code: ExceptionErrorCode.invalidImageExtension);
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

  Future<void> update() {
    throw UnimplementedError();
  }

  Future<void> delete() {
    throw UnimplementedError();
  }

  Future<void> like(String postId) async {
    try {
      Response response = await httpClient.patch('api/v1/posts/like?postId=$postId');

      switch(response.statusCode) {
        case 200:
          return;
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

  Future<void> unlike(String postId) async {
    try {
      Response response = await httpClient.patch('api/v1/posts/unlike?postId=$postId');

      switch(response.statusCode) {
        case 200:
          return;
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

  Future<List<Comment>> getComments(String postId, {int skip = 0, int limit = 5}) async {
    try {
      Map<String, String> payload = {
        'skip': skip.toString(),
        'limit': limit.toString()
      };
      Response response = await httpClient.get('api/v1/posts/$postId/comments', payload);

      switch(response.statusCode) {
        case 200:
          List<Comment> commentListResponse = commentListFromJson(utf8.decode(response.bodyBytes));
          return commentListResponse;
        case 400:
          throw ResponseException(value: 'PostId không đúng', code: ExceptionErrorCode.invalid);
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

  Future<List<Comment>> getReplies(String postId, int commentId, {int skip = 0, int limit = 5}) async {
    try {
      Map<String, String> payload = {
        'commentId': commentId.toString(),
        'skip': skip.toString(),
        'limit': limit.toString()
      };
      Response response = await httpClient.get('api/v1/posts/$postId/comments/$commentId/replies', payload);

      switch(response.statusCode) {
        case 200:
          List<Comment> commentListResponse = commentListFromJson(utf8.decode(response.bodyBytes));
          return commentListResponse;
        case 400:
          throw ResponseException(value: 'CommentId không đúng', code: ExceptionErrorCode.invalid);
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

  Future<void> createComment(String postId, String content) async {
    try {
      Map<String, String> payload = {
        'content': content
      };
      Response response = await httpClient.post('api/v1/posts/$postId/comments', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'PostId không đúng', code: ExceptionErrorCode.invalid);
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

  Future<void> createReply(String postId, int commentId, String content) async {
    try {
      Map<String, String> payload = {
        'content': content
      };
      Response response = await httpClient.post('api/v1/posts/$postId/comments/$commentId/replies', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'CommentId không đúng', code: ExceptionErrorCode.invalid);
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