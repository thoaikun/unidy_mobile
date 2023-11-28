import 'dart:convert';
import 'package:http/http.dart';
import 'package:unidy_mobile/models/error_response_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/repository/user/user_repository.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  Future<User> whoAmI() async {
    try {
      Response response = await _userRepository.whoAmI();

      switch(response.statusCode) {
        case 200:
          User userResponse = userFromJson(utf8.decode(response.bodyBytes));
          return userResponse;
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

  Future<void> updateProfile(Map<String, dynamic> payload) async {
    try {
      Response response = await _userRepository.updateProfile(payload);

      switch (response.statusCode) {
        case 200:
          break;
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

  Future<String> updateProfileImage(MultipartFile file) async {
    try {
      Response response = await _userRepository.updateProfileImage(file);

      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body)['success'];
        case 400:
          throw ResponseException(value: 'Định dạng ảnh không phù hợp', code: ExceptionErrorCode.invalidImageExtension);
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

  Future<void> resetPassword(Map<String, String> payload, String token) async {
    try {
      Response response = await _userRepository.resetPassword(payload, token);

      switch(response.statusCode) {
        case 200:
          break;
        case 400:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalidResetPassword);
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