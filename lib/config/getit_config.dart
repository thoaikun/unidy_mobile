import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/services/authentication_service.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/organization_service.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/user_service.dart';

final getIt = GetIt.instance;

void configGetIt() async {
  //httpClient
  getIt.registerSingleton<HttpClient>(HttpClient(
      headers: {
        'Content-Type': 'application/json'
      }
  ));

  // local storage
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences());

  getIt.registerSingleton<AuthenticationService>(AuthenticationService());
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<PostService>(PostService());
  getIt.registerSingleton<CampaignService>(CampaignService());
  getIt.registerSingleton<OrganizationService>(OrganizationService());
}