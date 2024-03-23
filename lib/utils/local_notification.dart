import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:unidy_mobile/main.dart';
import 'package:unidy_mobile/screens/user/friends_list/friend_list/friend_list_container.dart';
import 'package:unidy_mobile/screens/user/friends_list/request_friend_list/request_friend_list_container.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotifications() async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/unidy');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse
    );
  }

  Future<void> displayNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

  Future<void> _onDidReceiveNotificationResponse(NotificationResponse? response) async {
    if (response == null || response.payload == null) return;
    Map<String, dynamic> data = jsonDecode(response.payload!);

    switch(data['type']) {
      case 'friendRequest':
        navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const RequestFriendListContainer()));
        break;
      case 'friendAccept':
        navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const FriendListContainer()));
        break;
    }
  }
}