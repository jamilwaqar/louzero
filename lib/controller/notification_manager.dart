import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/controller/constant/constants.dart';

class NotificationManager {
  static init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    String? token = await messaging.getToken();
    print('FCM token: $token');
    if (token != null) {
      GetStorage().write(GSKey.fcToken, token);
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    messaging.getInitialMessage().then((RemoteMessage? message) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen(messageOpenedApp);
  }

  static Future<void> logout() async {
    await FirebaseMessaging.instance.deleteToken();
    return;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('onMessageOpenedApp ${message.messageId}');
    });
    print('Handling a background message ${message.data}');
  }

  static handleNotification(GlobalKey<NavigatorState> navigatorKey) async {}

  static messageOpenedApp(RemoteMessage message) {}
}
