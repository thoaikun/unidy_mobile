import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/services/base_service.dart';

class OrganizationService extends Service {
  final int ORGANIZATION_LIMIT = 5;
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<void> getOrganizationInfo(int organizationId) async {
    throw UnimplementedError();
  }

  Future<void> getOrganizationCampaignPosts(int organizationId, String? cursor) async {
    throw UnimplementedError();
  }
}