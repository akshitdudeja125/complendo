// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/screens/home_screen.dart';
import 'package:complaint_portal/screens/login_screen.dart';
import 'package:complaint_portal/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../screens/error_screen.dart';
import '../screens/loading_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  //  Notice here we aren't using stateless/statefull widget. Instead we are using
  //  a custom widget that is a consumer of the state.
  //  So if any data changes in the state, the widget will be updated.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  now the build method takes a new paramaeter ScopeReader.
    //  this object will be used to access the provider.

    //  now the following variable contains an asyncValue so now we can use .when method
    //  to imply the condition
    final authState = ref.watch(authStateProvider);
    final data = ref.watch(dataProvider);
    print("AuthState->{$authState}");
    print("Data->{$data}");

    return authState.when(
        data: (user) {
          if (user != null) {
            return data.when(
                data: (data) {
                  if (data!['isProfileComplete']) {
                    return const HomePage();
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
