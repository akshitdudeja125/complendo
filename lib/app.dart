import 'package:complaint_portal/common/theme/theme_data.dart';
import 'package:complaint_portal/common/theme/theme_provider.dart';
import 'package:complaint_portal/features/auth/controllers/auth_controller.dart';
import 'package:complaint_portal/common/services/analytics/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


final container = ProviderContainer();

class MyApp extends ConsumerWidget {
  final ProviderContainer container;

  const MyApp({required this.container, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      home: AuthChecker(
        container: container,
      ),
    );
  }
}
