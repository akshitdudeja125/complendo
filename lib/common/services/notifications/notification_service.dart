import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/features/complaint/screens/view/view_complaint_screen.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var iosInitialization = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(message);
    });
  }

  void requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // user has granted permission
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // user has granted provisional permission
    } else {
      AppSettings.openNotificationSettings();
    }
  }

  void firebaseinit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());
      }
      initLocalNotifications(context, message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidChannel =
        const AndroidNotificationChannel(
      // Random().nextInt(100000).toString(),xx
      "1",
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',

      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      enableLights: true,
      ledColor: Colors.red,
    );
    var androidNotificationDetails = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: androidChannel.description,
      importance: Importance.max,
      ticker: 'ticker',
      priority: Priority.high,
      showWhen: true,
    );
    const darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    Future.delayed(Duration.zero, () async {
      await _flutterLocalNotificationsPlugin.show(
        // Random().nextInt(100000),
        1,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<void> setUpInteractedMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    //when app is closed and opened from notification
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }
    // when app is in background and opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessage(message);
    });
  }

  void handleMessage(RemoteMessage message) {
    if (message.data['id'] != null) {
      final cid = message.data['id'];
      FirebaseFirestore.instance
          .collection('complaints')
          .doc(cid)
          .get()
          .then((value) {
        Get.to(
          () => ComplaintScreen(
            // cid: Complaint.fromMap(value.data()!).cid!,
            complaint: Complaint.fromMap(value.data()!),
          ),
        );
      });
    }
  }

  Future<String> getToken() async {
    //check if token is refreshed and then return it
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

  void isTokenRefreshed() {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      debugPrint('Token refreshed: $event');
    });
  }

  Future<void> sendNotifcationToUser({
    required String? reciever,
    required String? title,
    required String? body,
    // String? id,
    String? cid,
  }) async {
    var data = {
      "to": reciever,
      "priority": "high",
      "notification": {
        "body": body,
        "title": title,
      },
      "data": {
        "id": cid,
      }
    };
    var serverToken =
        "AAAAibfMiIE:APA91bFKdtE2CuszLZFGntD63lRuOhi6FRvo-uoCYMJLtyfFzOy0FDq1nxKkYUE39uODH6aGN1YOByMZSqJ0pgeUT7I_2922XihgqueMelzEkEA76xXIavvgijaHlCXkPKBa3JukGewX";
    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$serverToken'
      },
    );
  }
}
