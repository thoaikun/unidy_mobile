import 'dart:convert';
import 'package:http/http.dart';
import 'package:unidy_mobile/models/error_response_model.dart';
import 'package:unidy_mobile/repository/user/user_repository.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class UserService {
  UserRepository userRepository = UserRepository();

  Future<void> resetPassword(Map<String, String> payload, String token) async {
    try {
      Response response = await userRepository.resetPassword(payload, token);

      switch(response.statusCode) {
        case 200:
          break;
        case 400:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidResetPassword);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }
}