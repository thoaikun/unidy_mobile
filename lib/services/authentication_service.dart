import 'dart:convert';

import 'package:http/http.dart';
import 'package:unidy_mobile/models/authentication/authenticate_model.dart';
import 'package:unidy_mobile/models/error_response_model.dart';
import 'package:unidy_mobile/repository/authentication/authentication_repository.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class AuthenticationService {
  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  
  Future<Authenticate> login(Map<String, String> payload) async {
    try {
      Response response = await authenticationRepository.authenticate(payload);

      switch(response.statusCode) {
        case 200:
          Authenticate authenticationResponse = authenticateFromJson(utf8.decode(response.bodyBytes));
          return authenticationResponse;
        case 404:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidLogin);
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
      Response response = await authenticationRepository.createAccount(payload);

      switch(response.statusCode) {
        case 200:
          return response;
        case 400:
          ErrorResponse errorResponse = errorFromJson(response.body);
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidLogin);
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
      await authenticationRepository.logout();
    }
    catch (error) {
      rethrow;
    }
  }

  Future<void> confirmEmail(Map<String, String> payload) async {
    try {
      Response response = await authenticationRepository.confirmEmail(payload);

      switch (response.statusCode) {
        case 200:
          return;
        case 400:
          ErrorResponse errorResponse = errorFromJson(response.body);
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidLogin);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<void> submitOtp(Map<String, String> payload) async {
    try {
      Response response = await authenticationRepository.confirmEmail(payload);

      switch (response.statusCode) {
        case 200:
          return;
        case 400:
          ErrorResponse errorResponse = errorFromJson(response.body);
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidLogin);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }
}