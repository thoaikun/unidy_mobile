import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/authenticate_model.dart';
import 'package:unidy_mobile/models/error_response_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class AuthenticationService extends Service {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<Authenticate> login(Map<String, String> payload) async {
    try {
      Response response = await httpClient.post('api/v1/auth/authenticate', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          Authenticate authenticationResponse = authenticateFromJson(utf8.decode(response.bodyBytes));
          return authenticationResponse;
        case 404:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidLogin);
        case 403:
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        case 406:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.notApproveAccount);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<Response> signUp(Map<String, String> payload) async {
    try {
      Response response = await httpClient.post('api/v1/auth/register', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          return response;
        case 400:
          ErrorResponse errorResponse = errorFromJson(response.body);
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidLogin);
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

  Future<String> refreshYourToken() async {
    // TODO double check again with Thai
    throw UnimplementedError();
  }

  Future<void> logout() async {
    try {
      await httpClient.get('api/v1/auth/refresh-token');
    }
    catch (error) {
      rethrow;
    }
  }

  Future<void> confirmEmail(Map<String, String> payload) async {
    try {
      Response response = await httpClient.post('api/v1/auth/send-OTP', json.encode(payload));

      switch (response.statusCode) {
        case 200:
          return;
        case 400:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidEmail);
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

  Future<Authenticate> confirmOtp(Map<String, String> payload) async {
    try {
      Response response = await httpClient.post('api/v1/auth/submit-OTP', json.encode(payload));

      switch (response.statusCode) {
        case 200:
          Authenticate authenticationResponse = authenticateFromJson(utf8.decode(response.bodyBytes));
          return authenticationResponse;
        case 400:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidOtp);
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
}