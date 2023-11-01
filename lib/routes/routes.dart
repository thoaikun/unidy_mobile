import 'package:flutter/material.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/screens/authentication/signup/signup_screen.dart';
import 'package:unidy_mobile/screens/user/campaign_detail/campaign_detail.dart';
import 'package:unidy_mobile/screens/user/friends_list/friends_list_screen.dart';
import 'package:unidy_mobile/screens/user/friends_list/request_friends_list_screen.dart';
import 'package:unidy_mobile/screens/user/friends_list/suggestion_friend_list_screen.dart';
import 'package:unidy_mobile/screens/user/notification/notification_screen.dart';
import 'package:unidy_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:unidy_mobile/screens/user/home/home_screen.dart';
import 'package:unidy_mobile/screens/placeholder/placeholder.dart';

Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)> {
  '/placeholder': (context) => const PlaceholderScreen(),
  '/': (context) => const HomeScreen(),
  '/authentication/login': (context) => const LoginScreen(),
  '/authentication/signup': (context) => const SignUpScreen(),
  '/onboarding': (context) => const OnboardingScreen(),
  '/post_detail': (context) => Container(),
  '/notification': (context) => const NotificationScreen(),
  '/search/posts': (context) => Container(),
  '/search/organizations': (context) => Container(),
  '/search/users': (context) => Container(),
  '/friends/suggestion': (context) => const SuggestionFriendListScreen(),
  '/friends/request': (context) => const RequestFriendListScreen(),
  '/friends/list': (context) => const FriendListScreen(),
  '/campaign': (context) => const CampaignDetailScreen(),
  'profile': (context) => Container(),

  '/organization': (context) => Container(),
  '/organization/campaign': (context) => Container(),
  '/organization/add': (context) => Container(),
  '/organization/edit': (context) => Container()
};