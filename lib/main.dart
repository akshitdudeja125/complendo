// ignore_for_file: avoid_print

// import 'dart:async';
// import 'package:complaint_portal/app.dart';
// import 'package:complaint_portal/common/services/notifications/push_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'firebase_options.dart';

// final container = ProviderContainer();

// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {}

// void _onDidReceiveNotificationResponse(
//   NotificationResponse details,
// ) {
//   selectNotificationStream.add(details);
// }

// final StreamController<NotificationResponse?> selectNotificationStream =
//     StreamController<NotificationResponse?>.broadcast();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//   await NotificationService.initializeNotificationService(
//       _onDidReceiveNotificationResponse);

//   runApp(
//     ProviderScope(
//       child: MyApp(
//         container: container,
//       ),
//     ),
//   );

//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
// }

import 'dart:async';
import 'package:complaint_portal/app.dart';
import 'package:complaint_portal/common/services/notifications/push_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

final container = ProviderContainer();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message with details ${message.data}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ProviderScope(
      child: MyApp(
        container: container,
      ),
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
} 
