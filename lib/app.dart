import 'package:complaint_portal/features/auth/controllers/auth_controller.dart';
import 'package:complaint_portal/features/services/analytics/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  final ProviderContainer container;

  const MyApp({Key? key, required this.container}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GetMaterialApp(
        navigatorKey: Get.key,
        scrollBehavior: const ScrollBehavior(),
        navigatorObservers: [
          FirebaseAnalyticsService().appAnalyticsObserver(),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.lora().fontFamily,
        ),
        home: const AuthChecker(),
      ),
    );
  }
}
