import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class OrganizationService extends Service {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<Organization> getOrganizationInfo(int organizationId) async {
    try {
      Response response = await httpClient.get('api/v1/organization/get-profile?organizationId=$organizationId');

      switch(response.statusCode) {
        case 200:
          Organization organizationResponse = organizationFromJson(utf8.decode(response.bodyBytes));
          return organizationResponse;
        case 400:
          throw ResponseException(value: 'organization id không đúng', code: ExceptionErrorCode.invalidUserId);
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (e) {
      rethrow;
    }
  }
}