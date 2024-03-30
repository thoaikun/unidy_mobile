import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';

class FirebaseService {
  HttpClient httpClient = GetIt.instance<HttpClient>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await registerFcmToken();
  }

  Future<void> registerFcmToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      if (token != null) {
        Map<String, String> payload = {
          'fcmToken': token
        };
        Response res = await httpClient.post('api/v1/firebaseNotification/initFcmToken', jsonEncode(payload));
        if (res.statusCode == 200) {
          print('Firebase token registered');
        }
      }
    }
    catch (error) {
      rethrow;
    }
  }

  void subscribeToTopic(String topic) {
    _firebaseMessaging.getToken().then((token) {
      print('Token: $token');
    });
    _firebaseMessaging.subscribeToTopic(topic);
  }
}