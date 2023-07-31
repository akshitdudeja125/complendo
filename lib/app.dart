import 'package:complaint_portal/common/theme/theme_data.dart';
import 'package:complaint_portal/common/theme/theme_provider.dart';
import 'package:complaint_portal/features/auth/controllers/auth_controller.dart';
import 'package:complaint_portal/common/services/analytics/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final container = ProviderContainer();

class MyApp extends ConsumerStatefulWidget {
  final ProviderContainer container;
  final SharedPreferences prefs;

  const MyApp({required this.prefs, required this.container, super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(isDarkProvider.notifier).state =
          widget.prefs.getBool('isDark') ?? false;
    });
  }

  // final prefs =
  //                                 await SharedPreferences.getInstance();
  //                             prefs.setBool('isDark', value);
//                             ref.watch(isDarkProvider.notifier).state = value;
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
      home: AuthChecker(
        container: widget.container,
        prefs: widget.prefs,
      ),
    );
  }
}
