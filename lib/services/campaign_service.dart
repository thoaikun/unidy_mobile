import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class CampaignService extends Service {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<CampaignData> getRecommendCampaign({int skip = 0, int limit=5}) async {
    try {
      Map<String, dynamic> payload = {
        'skip': skip.toString(),
        'limit': limit.toString(),
      };
      Response response = await httpClient.get('api/v1/campaign/recommendation', payload);

      switch(response.statusCode) {
        case 200:
          CampaignData campaignData = campaignDataFromJson(utf8.decode(response.bodyBytes));
          return campaignData;
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<CampaignData> getOrganizationCampaignPosts(int organizationId, {int skip = 0, int limit = 5}) async {
    try {
      Map<String, dynamic> payload = {
        'skip': skip.toString(),
        'limit': limit.toString(),
      };
      Response response = await httpClient.get('api/v1/campaign/organization/$organizationId', payload);

      switch(response.statusCode) {
        case 200:
          CampaignData campaignData = campaignDataFromJson(utf8.decode(response.bodyBytes));
          return campaignData;
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

  Future<void> create(Map<String, String> payload, List<MultipartFile> files) async {
    try {
      StreamedResponse streamedResponse = await httpClient.uploadImage('api/v1/campaign', files, payload);
      Response response = await Response.fromStream(streamedResponse);

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Dữ liệu không hợp lệ', code: ExceptionErrorCode.invalidInput);
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch (error) {
      rethrow;
    }
  }

  Future<void> registerAsVolunteer(String campaignId) async {
    try {
      Response response = await httpClient.get('api/v1/campaign/register?campaignId=$campaignId',);

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Dữ liệu không hợp lệ', code: ExceptionErrorCode.invalidInput);
        case 403:
          catchForbidden();
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