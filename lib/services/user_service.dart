import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/error_response_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class UserService {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<User> whoAmI() async {
    if (httpClient.headers?.containsKey('Authorization') == false) {
      return User(userId: 0);
    }

    try {
      Response response = await httpClient.get('api/v1/users/profile');

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
      Response response = await httpClient.patch('api/v1/users/profile', jsonEncode(payload));

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
      StreamedResponse streamedResponse = await httpClient.uploadImage('api/v1/users/update-profile-image', [file]);
      Response response = await Response.fromStream(streamedResponse);

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
      httpClient.addHeader('Authorization', 'Bearer $token');
      Response response = await httpClient.patch('api/v1/users/new-password', jsonEncode(payload));

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