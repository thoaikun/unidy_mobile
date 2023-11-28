import 'package:http/http.dart';

abstract class IPostRepository {
  Future<Response> getPostsByUserId(int userId);
  Future<Response> getPostDetailByUserId(int postId);
}

