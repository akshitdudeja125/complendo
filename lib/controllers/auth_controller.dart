import 'package:complaint_portal/providers/database_provider.dart';
import 'package:complaint_portal/screens/page_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_page.dart';
import '../screens/error_screen.dart';
import '../screens/loading_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final data = ref.watch(userDataProvider);
    return authState.when(
        data: (user) {
          if (user != null) {
            return data.when(
                data: (data) {
                  if (data!['isProfileComplete']) {
                    return const PageNavigator();
                  } else {
                    return const RegisterScreen();
                  }
                },
                loading: () => const LoadingScreen(),
                error: (e, trace) => ErrorScreen(e, trace));
          }
          return const LoginScreen();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(e, trace));
  }
}



// import 'package:complaint_portal/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../screens/login_screen.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return const HomePage();
//           } else {
//             return const LoginScreen();
//           }
//         },
//       ),
//     );
//   }
// }
