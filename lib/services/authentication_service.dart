import 'package:http/http.dart';
import 'package:unidy_mobile/models/authentication/authenticate_model.dart';
import 'package:unidy_mobile/models/authentication/registration_model.dart';
import 'package:unidy_mobile/repository/authentication/authentication_repository.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class AuthenticationService {
  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  
  Future<Authenticate> login(Map<String, String> payload) async {
    try {
      Response response = await authenticationRepository.authenticate(payload);
      Authenticate authenticationResponse = authenticateFromJson(response.body);

      switch(authenticationResponse.statusCodeValue) {
        case 200:
          return authenticationResponse;
        case 400:
          throw ResponseException(value: 'Thông tin tài khoản sai', code: ExceptionErrorCode.invalidLogin);
        case 404:
          throw ResponseException(value: 'Tài khoản chưa được tạo', code: ExceptionErrorCode.invalidLogin);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<Registration> signUp(Map<String, String> payload) async {
    try {
      Response response = await authenticationRepository.createAccount(payload);
      Registration registrationResponse = registrationFromJson(response.body);

      switch(registrationResponse.statusCodeValue) {
        case 200:
          return registrationResponse;
        case 400:
          throw ResponseException(value: 'Đăng ký tài khoản không thành công', code: ExceptionErrorCode.invalidRegistration);
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
          throw ResponseException(value: 'Email chưa được sử dụng', code: ExceptionErrorCode.invalidEmail);
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
          throw ResponseException(value: 'OTP không hợp lệ', code: ExceptionErrorCode.invalidOtp);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }
}