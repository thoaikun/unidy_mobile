import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/campaign_joined_history_model.dart';
import 'package:unidy_mobile/models/donation_history_model.dart';
import 'package:unidy_mobile/models/error_response_model.dart';
import 'package:unidy_mobile/models/friend_model.dart';
import 'package:unidy_mobile/models/notification_model.dart';
import 'package:unidy_mobile/models/organization_model.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/services/firebase_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class UserService extends Service {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<User> whoAmI() async {
    try {
      Response response = await httpClient.get('api/v1/users/profile');

      switch(response.statusCode) {
        case 200:
          User userResponse = userFromJson(utf8.decode(response.bodyBytes));
          return userResponse;
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

  Future<User> getOtherUserProfile(int userId) async {
    try {
      Response response = await httpClient.get('api/v1/users/profile/volunteers/$userId');

      switch(response.statusCode) {
        case 200:
          User userResponse = userFromJson(utf8.decode(response.bodyBytes));
          return userResponse;
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

  Future<Organization> getOrganizationInfo(int organizationId) async {
    try {
      Response response = await httpClient.get('api/v1/users/profile/organizations/$organizationId');

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

  Future<void> updateProfile(Map<String, dynamic> payload) async {
    try {
      Response response = await httpClient.patch('api/v1/users/profile', jsonEncode(payload));

      switch (response.statusCode) {
        case 200:
          break;
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

  Future<void> initFavoriteCategoryList(Map<String, dynamic> payload) async {
    try {
      Response response = await httpClient.post('api/v1/users/choose-favorite-activities', jsonEncode(payload));

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          ErrorResponse errorResponse = errorFromJson(utf8.decode(response.bodyBytes));
          throw ResponseException(value: errorResponse.error, code: ExceptionErrorCode.invalid);
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


  Future<void> sendFriendRequest(int userId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/add-friend?friendId=$userId');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Lời mời kết bạn không hợp lệ', code: ExceptionErrorCode.invalidFriendRequest);
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

  Future<void> deleteFriendRequest(int userId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/delete-invite?friendIdRequest=$userId');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Không thể xóa lời mời kết bạn', code: ExceptionErrorCode.invalidFriendRequest);
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

  Future<void> acceptFriendRequest(int userId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/accept-friend?friendId=$userId');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Không thể chấp nhận lời mời kết bạn', code: ExceptionErrorCode.invalidFriendRequest);
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

  Future<void> declineFriendRequest(int userId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/delete-invite?friendId=$userId');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Không thể từ chối lời mời kết bạn', code: ExceptionErrorCode.invalidFriendRequest);
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

  Future<void> unfriend(int userId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/unfriend?friendId=$userId');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Không thể xóa bạn bè', code: ExceptionErrorCode.invalidFriendRequest);
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

  Future<List<FriendRequest>> getFriendRequests({int skip = 0, int limit = 5}) async {
    try {
      Map<String, String> payload = {
        'skip': skip.toString(),
        'limit': limit.toString()
      };
      Response response = await httpClient.get('api/v1/users/list-invite', payload);

      switch(response.statusCode) {
        case 200:
          List<FriendRequest> friendRequestResponse = friendRequestListFromJson(utf8.decode(response.bodyBytes));
          return friendRequestResponse;
        case 400:
          throw ResponseException(value: 'Không thể lấy danh sách lời mời kết bạn', code: ExceptionErrorCode.invalidFriendRequest);
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch(error) {
      rethrow;
    }
  }

  Future<List<Friend>> getFriends({int skip = 0, int limit = 5}) async {
    try {
      Map<String, String> payload = {
        'skip': skip.toString(),
        'limit': limit.toString()
      };
      Response response = await httpClient.get('api/v1/users/get-list-friend', payload);

      switch(response.statusCode) {
        case 200:
          List<Friend> friends = friendListFromJson(utf8.decode(response.bodyBytes));
          for (var element in friends) {element.isFollow = true;}
          return friends;
        case 400:
          throw ResponseException(value: 'Không thể lấy danh sách bạn bè', code: ExceptionErrorCode.invalidFriendRequest);
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch(error) {
      rethrow;
    }
  }

  Future<List<FriendSuggestion>> getRecommendations({int skip = 0, int limit = 5, rangeEnd = 4}) async {
    try {
      Map<String, String> payload = {
        'skip': skip.toString(),
        'limit': limit.toString(),
        'rangeEnd': rangeEnd.toString()
      };
      Response response = await httpClient.get('api/v1/users/get-recommend-friend', payload);

      switch(response.statusCode) {
        case 200:
          List<FriendSuggestion> friendSuggestions = friendSuggestionListFromJson(utf8.decode(response.bodyBytes));
          return friendSuggestions;
        case 400:
          throw ResponseException(value: 'Không thể lấy danh sách gợi ý', code: ExceptionErrorCode.invalidFriendRequest);
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch(error) {
      rethrow;
    }
  }


  Future<String> followOrganization(int organizationId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/follow-organization?organizationId=$organizationId');

      switch(response.statusCode) {
        case 200:
          String topic = jsonDecode(response.body)['topic'];
          return topic;
        case 400:
          throw ResponseException(value: 'Không thể theo dõi tổ chức', code: ExceptionErrorCode.invalidFollowOrganization);
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

  Future<void> unfollowOrganization(int organizationId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/unfollow-organization?organizationId=$organizationId');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Không thể bỏ theo dõi tổ chức', code: ExceptionErrorCode.invalidFollowOrganization);
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

  Future<List<CampaignJoinedHistory>> getJoinedCampaign({ int size = 5, int page = 0}) async {
    try {
      Map<String, String> payload = {
        'pageSize': size.toString(),
        'pageNumber': page.toString()
      };
      Response response = await httpClient.get('api/v1/users/campaigns', payload);

      switch(response.statusCode) {
        case 200:
          List<CampaignJoinedHistory> campaignJoinedHistory = campaignJoinedHistoryListFromJson(utf8.decode(response.bodyBytes));
          return campaignJoinedHistory;
        case 400:
          throw ResponseException(value: 'Không thể lấy thông tin chiến dịch đã tham gia', code: ExceptionErrorCode.invalid);
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch(error) {
      rethrow;
    }
  }

  Future<List<DonationHistory>> getDonationHistory({int size = 5, int page = 0}) async {
    try {
      Map<String, String> payload = {
        'pageSize': size.toString(),
        'pageNumber': page.toString()
      };
      Response response = await httpClient.get('api/v1/users/transactions', payload);

      switch(response.statusCode) {
        case 200:
          List<DonationHistory> donationHistory = listDonationHistoryFromJson(utf8.decode(response.bodyBytes));
          return donationHistory;
        case 400:
          throw ResponseException(value: 'Không thể lấy lịch sử quyên góp', code: ExceptionErrorCode.invalid);
        case 403:
          catchForbidden();
          throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
        default:
          throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
      }
    }
    catch(error) {
      rethrow;
    }
  }


  Future<List<NotificationItem>> getNotifications({int pageSize = 10, int pageNumber = 0}) async {
    try {
      Map<String, String> payload = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString()
      };
      Response response = await httpClient.get('api/v1/users/notifications', payload);

      switch(response.statusCode) {
        case 200:
          List<NotificationItem> notificationItems = notificationItemListFromJson(utf8.decode(response.bodyBytes));
          return notificationItems;
        case 400:
          throw ResponseException(value: 'Không thể lấy thông báo', code: ExceptionErrorCode.invalid);
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

  Future<int> getTotalUnseenNotification() async {
    try {
      Response response = await httpClient.get('api/v1/users/notifications/unseen/count');

      switch(response.statusCode) {
        case 200:
          return jsonDecode(response.body)['unseenCount'];
        case 400:
          throw ResponseException(value: 'Không thể lấy thông báo chưa đọc', code: ExceptionErrorCode.invalid);
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

  Future<void> markAllNotificationAsRead() async {
    try {
      Response response = await httpClient.patch('api/v1/users/notifications/unseen');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Không thể đánh dấu tất cả thông báo đã đọc', code: ExceptionErrorCode.invalid);
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

  Future<void> markNotificationAsRead(int notificationId) async {
    try {
      Response response = await httpClient.patch('api/v1/users/notifications/unseen/$notificationId');

      switch(response.statusCode) {
        case 200:
          return;
        case 400:
          throw ResponseException(value: 'Không thể đánh dấu thông báo đã đọc', code: ExceptionErrorCode.invalid);
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