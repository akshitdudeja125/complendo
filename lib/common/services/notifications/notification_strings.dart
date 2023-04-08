import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//* Channel PUSH notifications

const channelId = 'com.example.complaint_portal';
const channelKey = 'com.example.complaint_portal';
const channelName = 'Channel Name';
const channelDescription = 'Channel Description';

//* IOS Settings
final iosInitializationSettings = DarwinInitializationSettings(
  notificationCategories: [
    DarwinNotificationCategory(
      channelId,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain(
          channelKey,
          'Tienes una nueva notificacion',
          options: {
            DarwinNotificationActionOption.foreground,
          },
        ),
      ],
    ),
  ],
  onDidReceiveLocalNotification:
      (int id, String? title, String? body, String? payload) {},
);

//* Android Settings
const androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/launcher_icon');

const androidChannel = AndroidNotificationChannel(
  channelId,
  channelName,
  description: channelDescription,
  importance: Importance.max,
  enableLights: true,
  ledColor: Colors.red,
);

const pushNotificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription: channelDescription,
    color: Colors.red,
    ledColor: Colors.red,
    visibility: NotificationVisibility.public,
    importance: Importance.max,
    ledOnMs: 100,
    ledOffMs: 1000,
    category: AndroidNotificationCategory.message,
  ),
  iOS: DarwinNotificationDetails(
    presentSound: true,
    presentAlert: true,
    presentBadge: true,
  ),
);
