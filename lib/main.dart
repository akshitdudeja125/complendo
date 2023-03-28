import 'package:complaint_portal/services/analytics_service.dart';
import 'package:complaint_portal/services/secure_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

final container = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize App Check

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   androidProvider: AndroidProvider.debug,
  // );

  runApp(
    MyApp(
      container: container,
    ),
    // provider container
  );
}

class MyApp extends StatelessWidget {
  final ProviderContainer container;

  const MyApp({Key? key, required this.container}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ProviderContainer container;
    return ProviderScope(
      child: GetMaterialApp(
        navigatorKey: Get.key,
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
