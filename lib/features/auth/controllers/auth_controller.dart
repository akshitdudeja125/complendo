import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/common/services/notifications/notification_service.dart';
import 'package:complaint_portal/features/auth/features/login/login_page.dart';
import 'package:complaint_portal/features/auth/features/register/screens/register_page.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/landing/landing_page.dart';
import 'package:complaint_portal/features/error/error_screen.dart';
import 'package:complaint_portal/features/loading/loading_screen.dart';
import 'package:complaint_portal/features/navigation/navigator.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

// create a state provider to store the user

//CREATE A PROVIDER WHICH CONTNINOUSLY CHECKS IF NETWORK IS AVAILABLE OR NOT
final isNetworkAvailableProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.map((event) {
    if (event == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  });
});

class AuthChecker extends ConsumerStatefulWidget {
  final ProviderContainer container;

  const AuthChecker({Key? key, required this.container}) : super(key: key);

  @override
  ConsumerState<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends ConsumerState<AuthChecker> {
  String? token;
  @override
  void initState() {
    super.initState();
    NotificationService().requestNotificationPermissions();
    NotificationService().firebaseinit(context);
    NotificationService().setUpInteractedMessage(context);
    NotificationService().getToken().then((value) {
      token = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNetworkAvailable = ref.watch(isNetworkAvailableProvider);
    return isNetworkAvailable.when(
      data: (value) {
        if (value == false) {
          return Scaffold(
            body: Center(
              child: Lottie.asset('assets/lottie/internet_unavailable_2.json'),
            ),
          );
        } else {
          final authState = ref.watch(authStateProvider);
          return authState.when(
              data: (authuser) {
                if (authuser == null) {
                  if (ref.watch(isTermsCheckedProvider) == false) {
                    return const LandingScreen();
                  } else {
                    return const LoginPage();
                  }
                }
                final data = ref.watch(userDataStreamProvider(authuser.uid));
                return data.when(
                  data: (value) {
                    if (value == null) {
                      // usp.removeUser();
                      return const RegisterScreen();
                    }
                    final UserModel user = UserModel.fromMap(value);
                    return PageNavigator(
                      user: user,
                      // user: value,
                    );
                  },
                  loading: () => const LoadingScreen(),
                  error: (e, trace) => ErrorScreen(e, trace),
                );
              },
              loading: () => const LoadingScreen(),
              error: (e, trace) => ErrorScreen(e, trace));
        }
      },
      loading: () => const LoadingScreen(),
      error: (e, trace) => ErrorScreen(e, trace),
    );
  }
}

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel? user) => state = user;
  void removeUser() => state = null;
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

//how to use this provider
// final user = ref.watch(userProvider);
// if (user != null) {

