import 'package:get_it/get_it.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/services/authentication_service.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/services/firebase_service.dart';
import 'package:unidy_mobile/services/organization_service.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:unidy_mobile/services/search_service.dart';
import 'package:unidy_mobile/services/transaction_service.dart';
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
  getIt.registerLazySingleton<CampaignService>(() => CampaignService());
  getIt.registerLazySingleton<OrganizationService>(() => OrganizationService());
  getIt.registerLazySingleton<TransactionService>(() => TransactionService());
  getIt.registerLazySingleton<SearchService>(() => SearchService());
  getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
}