
import 'package:http/http.dart';

abstract class IAuthenticationRepository {
  Future<Response> authenticate(Map<String, String> payload);
  Future<Response> createAccount(Map<String, String> payload);
  Future<Response> getRefreshToken();
  Future<void> logout();
  Future<Response> confirmEmail(Map<String, String> payload);
  Future<Response> submitOtp(Map<String, String> payload);
}