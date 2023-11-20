import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/src/response.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/repository/user/user_repository_interface.dart';

class UserRepository implements IUserRepository {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<Response> whoAmI() async {
    try {
      Response response = await httpClient.get('api/v1/users/profile?userId=13');
      return response;
    }
    catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> resetPassword(Map<String, String> payload, String token) async {
    httpClient.addHeader('Authorization', 'Bearer $token');
    try {
      Response response = await httpClient.patch('api/v1/users/new-password', jsonEncode(payload));
      return response;
    }
    catch (error)  {
      rethrow;
    }
  }

}