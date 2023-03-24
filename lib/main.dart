import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

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
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.lora().fontFamily,
      ),
      home: AuthChecker(),
    );
  }
}
// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'controllers/auth_controller.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Initialize App Check
//   runApp(const ProviderScope(child: MyApp()));
// }

// final firebaseAppCheckProvider = Provider<FirebaseAppCheck>((ref) {
//   return FirebaseAppCheck.instance;
// });

// final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
//   return await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// });

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final initialize = ref.watch(firebaseinitializerProvider);

//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: GoogleFonts.lora().fontFamily,
//       ),
//       home: initialize.when(
//         data: (value) => const AuthChecker(),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) => const Center(
//           child: Text('Error'),
//         ),
//       ),
//     );
//   }
// }
