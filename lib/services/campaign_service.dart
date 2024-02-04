import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/campaign_model.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class CampaignService {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<List<Campaign>> getRecommendCampaign() async {
    try {
      Response response = await httpClient.get('api/v1/campaign/getRecommendCampaign');

      switch(response.statusCode) {
        case 200:
          List<Campaign> campaignList = campaignListFromJson(utf8.decode(response.bodyBytes));
          return campaignList;
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