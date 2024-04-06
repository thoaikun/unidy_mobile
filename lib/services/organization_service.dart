import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/campaign_post_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/models/volunteer_join_campaign_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class OrganizationService extends Service {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<Organization> whoAmI() async {
    try {
      Response response = await httpClient.get('api/v1/organization/profile');

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

  Future<List<Campaign>> getOrganizationCampaigns({int pageSize = 5, int pageNumber = 0}) async {
    try {
      Map<String, String> payload = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString()
      };
      Response response = await httpClient.get('api/v1/organization/campaigns', payload);

      switch(response.statusCode) {
        case 200:
          List<Campaign> campaignResponse = listCampaignFromJson(utf8.decode(response.bodyBytes));
          return campaignResponse;
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

  Future<List<DonationHistory>> getDonations({int pageSize = 5, int pageNumber = 0, String sort = 'newest'}) async {
    try {
      Map<String, String> payload = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString(),
        'sort': sort
      };
      Response response = await httpClient.get('api/v1/organization/transactions', payload);

      switch(response.statusCode) {
        case 200:
          List<DonationHistory> donationHistoryResponse = listDonationHistoryFromJson(utf8.decode(response.bodyBytes));
          return donationHistoryResponse;
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

  Future<List<DonationHistory>> getDonationsInCampaign(String campaignId, {int pageSize = 5, int pageNumber = 0}) async {
    try {
      Map<String, String> payload = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString()
      };
      Response response = await httpClient.get('api/v1/organization/campaigns/$campaignId/transactions', payload);

      switch(response.statusCode) {
        case 200:
          List<DonationHistory> donationHistoryResponse = listDonationHistoryFromJson(utf8.decode(response.bodyBytes));
          return donationHistoryResponse;
        case 400:
          throw ResponseException(value: 'CampaignId không đúng', code: ExceptionErrorCode.invalidUserId);
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

  Future<List<VolunteerJoinCampaign>> getApprovedVolunteersInCampaign(String campaignId, { int pageSize = 5, int pageNumber = 0}) async {
    try {
      Map<String, String> payload = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString()
      };

      Response response = await httpClient.get('api/v1/organization/campaigns/$campaignId/approved-volunteers', payload);
      switch(response.statusCode) {
        case 200:
          List<VolunteerJoinCampaign> volunteerJoinCampaigns = listVolunteerJoinCampaignFromJson(utf8.decode(response.bodyBytes));
          return volunteerJoinCampaigns;
        case 400:
          throw ResponseException(value: 'CampaignId không đúng', code: ExceptionErrorCode.invalidUserId);
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

  Future<List<VolunteerJoinCampaign>> getNotApprovedVolunteersInCampaign(String campaignId, { int pageSize = 5, int pageNumber = 0}) async {
    try {
      Map<String, String> payload = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString()
      };

      Response response = await httpClient.get('api/v1/organization/campaigns/$campaignId/not-approved-volunteers', payload);
      switch(response.statusCode) {
        case 200:
          List<VolunteerJoinCampaign> volunteerJoinCampaigns = listVolunteerJoinCampaignFromJson(utf8.decode(response.bodyBytes));
          return volunteerJoinCampaigns;
        case 400:
          throw ResponseException(value: 'CampaignId không đúng', code: ExceptionErrorCode.invalidUserId);
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

  Future<void> approveVolunteersInCampaign(String campaignId, List<int> userIds) async {
    try {
      Map<String, dynamic> payload = {
        'volunteerIds': userIds
      };
      Response response = await httpClient.patch('api/v1/organization/campaigns/$campaignId/approve-volunteer', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'CampaignId không đúng hoặc số lượng thành viên vượt quá yêu cầu', code: ExceptionErrorCode.invalid);
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

  Future<void> rejectVolunteersInCampaign(String campaignId, List<int> userIds) async {
    try {
      Map<String, dynamic> payload = {
        'volunteerIds': userIds
      };
      Response response = await httpClient.patch('api/v1/organization/campaigns/$campaignId/reject-volunteer', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'CampaignId không đúng', code: ExceptionErrorCode.invalid);
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

  Future<void> endCampaign(String campaignId) async {
    try {
      Response response = await httpClient.patch('api/v1/organization/campaigns/$campaignId/end');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'CampaignId không đúng', code: ExceptionErrorCode.invalid);
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

  Future<void> updateCampaign(Map<String, String> payload, String campaignId) async {
    try {
      Response response = await httpClient.patch('api/v1/organization/campaigns/$campaignId', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'CampaignId không đúng', code: ExceptionErrorCode.invalid);
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