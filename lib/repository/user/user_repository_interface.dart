import 'package:http/http.dart';

abstract class IUserRepository {
  Future<Response> whoAmI();
  Future<Response> updateProfile(Map<String, String> payload);
  Future<void> updateProfileImage(MultipartFile file);
  Future<Response> resetPassword(Map<String, String> payload, String token);
}