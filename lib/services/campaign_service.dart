import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/utils/formatter_util.dart';

class CampaignService extends Service {
  final int CAMPAIGN_LIMIT = 3;
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<List<CampaignPost>> getRecommendCampaignFromRecommendService({int offset = 0}) async {
    try {
      Map<String, dynamic> payload = {
        'offset': offset.toString(),
        'limit': CAMPAIGN_LIMIT.toString(),
      };
      Response response = await httpClient.get('api/v1/campaign/getRecommendCampaign', payload);

      switch(response.statusCode) {
        case 200:
          List<CampaignPost> campaignList = campaignPostListFromJson(utf8.decode(response.bodyBytes));
          return campaignList;
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

  Future<List<CampaignPost>> getRecommendCampaignFromNeo4J(String? cursor) async {
    try {
      Map<String, dynamic> payload = {
        'cursor': cursor ?? Formatter.formatTime(DateTime.now(), 'yyyy-MM-ddTHH:mm:ss'),
        'limit': CAMPAIGN_LIMIT.toString(),
      };
      Response response = await httpClient.get('api/v1/campaign/getCampaignPost', payload);

      switch(response.statusCode) {
        case 200:
          List<CampaignPost> campaignList = campaignPostListFromJson(utf8.decode(response.bodyBytes));
          return campaignList;
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

  Future<void> registerAsVolunteer(int campaignId) async {
    try {
      Response response = await httpClient.post('api/v1/campaign/register-as-volunteer', { 'campaignId': campaignId });

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