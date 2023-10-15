import 'package:flutter/material.dart';
import 'package:unidy_mobile/screens/user/home.dart';

Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)> {
  '/': (context) => const Home(),
  '/authentication/login': (context) => Container(),
  '/authentication/signup': (context) => Container(),
  '/onboarding': (context) => Container(),
  '/notification': (context) => Container(),
  'search/posts': (context) => Container(),
  'search/organizations': (context) => Container(),
  'search/users': (context) => Container(),
  'friends/suggestion': (context) => Container(),
  'friends/request': (context) => Container(),
  'friends/list': (context) => Container(),
  'campaign': (context) => Container(),
  'profile': (context) => Container(),

  '/organization': (context) => Container(),
  '/organization/campaign': (context) => Container(),
  '/organization/add': (context) => Container(),
  '/organization/edit': (context) => Container()
};