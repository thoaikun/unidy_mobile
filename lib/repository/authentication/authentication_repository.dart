import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'authentication_repository_interface.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  @override
  Future<Response> authenticate(Map<String, String> payload) async {
    try {
      Response response = await httpClient.post('api/v1/auth/authenticate', jsonEncode(payload));
      return response;
    }
    catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> createAccount(Map<String, String> payload) async{
    try {
      Response response = await httpClient.post('api/v1/auth/register', jsonEncode(payload));
      return response;
    }
    catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> getRefreshToken() async {
    try {
      Response response = await httpClient.get('api/v1/auth/refresh-token');
      return response;
    }
    catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await httpClient.get('api/v1/auth/register');
    }
    catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> confirmEmail(Map<String, String> payload) async {
    try {
      Response response = await httpClient.post('api/v1/auth/send-email-reset-password', payload);
      return response;
    }
    catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> submitOtp(Map<String, String> payload) async {
    try {
      Response response = await httpClient.post('api/v1/auth/submit', payload);
      return response;
    }
    catch (error) {
      rethrow;
    }
  }
}