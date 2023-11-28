import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/repository/post/post_repository_interface.dart';

class PostRepository implements IPostRepository {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  @override
  Future<Response> getPostDetailByUserId(int postId) async {
    try {
      Response response = await httpClient.get('api/v1/post/get-post-by-postId', {
        "postId": postId
      });
      return response;
    }
    catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> getPostsByUserId(int userId) async {
    try {
      Response response = await httpClient.get('api/v1/post/get-post-by-userId', {
        'userId': userId
      });
      return response;
    }
    catch (error) {
      rethrow;
    }
  }
}