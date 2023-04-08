// ignore_for_file: avoid_print

import 'package:complaint_portal/common/services/notifications/push_notifications.dart';
import 'package:complaint_portal/common/theme/theme_data.dart';
import 'package:complaint_portal/common/theme/theme_provider.dart';
import 'package:complaint_portal/features/auth/controllers/auth_controller.dart';
import 'package:complaint_portal/common/services/analytics/analytics_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'main.dart';

final container = ProviderContainer();

class MyApp extends ConsumerStatefulWidget {
  final ProviderContainer container;

  const MyApp({Key? key, required this.container}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationService().requestNotificationPermissions();
    NotificationService().firebaseinit(context);
    NotificationService().setUpInteractedMessage(context);
    NotificationService().getToken().then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      scrollBehavior: const ScrollBehavior(),
      navigatorObservers: [
        FirebaseAnalyticsService().appAnalyticsObserver(),
      ],
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ref.watch(isDarkProvider) ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const AuthChecker(),
    );
  }
}

// eggqZrd3Slq-pT_Hmc5Hi2:APA91bHknYOruwnqKhGpIO19nmuyIW5sGIXLU8szvf-snDcjE82pIT5D7TX6sVvPqJ0NToa_pZllXOQeSw_8voMQCvvDN-JFMdpnkOqdWroZCremvLOlpQrJEqKphAR_Ln__6NgZs1AA