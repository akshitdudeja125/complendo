import 'package:complaint_portal/features/auth/features/login/login_page.dart';
import 'package:complaint_portal/features/auth/features/register/screens/register_page.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/landing/landing_page.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/features/error/error_screen.dart';
import 'package:complaint_portal/features/loading/loading_screen.dart';
import 'package:complaint_portal/features/navigation/navigator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (user) {
          if (user == null) {
            if (ref.watch(isTermsCheckedProvider) == false) {
              return const LandingScreen();
            } else {
              return const LoginPage();
            }
          }
          final data = ref.watch(userDataStreamProvider(user.uid));
          return data.when(
            data: (value) {
              if (value == null) return const RegisterScreen();
              return const PageNavigator();
            },
            loading: () => const LoadingScreen(),
            error: (e, trace) => ErrorScreen(e, trace),
          );
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(e, trace));
  }
}

// create a stream provide which continously checks if user with uid exists in database or not
// if it does not exist then it will return null
final userDataStreamProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>?, String?>((ref, uid) {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);
  return firebaseInstance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((event) => event.data());
});
