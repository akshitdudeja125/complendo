import 'package:complaint_portal/screens/home_screen.dart';
import 'package:complaint_portal/screens/login_screen.dart';
import 'package:complaint_portal/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RouteManager extends StatelessWidget {
  const RouteManager({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(title: 'InstiComplaints', routes: {
      '/register': (context) => const RegisterScreen(),
      '/': (context) => (FirebaseAuth.instance.currentUser == null)
          ? const LoginScreen()
          : const HomePage(),
      'home': (context) => const HomePage(),
    });
  }
}
