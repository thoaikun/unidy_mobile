import 'package:http/http.dart';

abstract class IUserRepository {
  Future<Response> resetPassword(Map<String, String> payload, String token);
}