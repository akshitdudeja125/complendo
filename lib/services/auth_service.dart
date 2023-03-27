// ignore_for_file: use_build_context_synchronously

import 'package:complaint_portal/services/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('Error Occured'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("OK"))
                  ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        // print('Email already in use.');
      } else {
        // print('Error: $e');
      }
    }
  }

  //  SignIn the user Google
  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _auth.signInWithCredential(credential);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged in successfully'),
          ),
        );
        // Add the user to the database if not already present
        await UserRepository().createUser(
          _auth.currentUser!.uid,
          _auth.currentUser!.displayName,
          _auth.currentUser!.email,
          _auth.currentUser!.photoURL,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Error Occured'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("OK"))
            ],
          ),
        );
      }
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

// import 'package:complaint_portal/screens/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../controllers/auth_controller.dart';
// import '../screens/home_screen.dart';
// import '../screens/register_page.dart';


// class AuthService2 {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   signOut(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     await GoogleSignIn().signOut();
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Logged out successfully'),
//       ),
//     );
//     // Navigator.of(context).pushAndRemoveUntil(
//     // MaterialPageRoute(builder: (context) => const AuthPage()),
//     // (Route route) => false);
//   }

//   signInWithGoogle(
//     BuildContext context,
//   ) async {
//     try {
//       final googleUser = await GoogleSignIn().signIn();
//       final googleAuth = await googleUser!.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       final UserCredential currentUser =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       if (currentUser.additionalUserInfo!.isNewUser) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const RegisterScreen()),
//             (Route route) => false);
//       } else {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const HomePage()),
//             (Route route) => false);
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Google sign in Succesful'),
//         ),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Google sign in failed'),
//         ),
//       );
//     }
//   }

// //   void ifError(error, BuildContext context) {
// //     if (error.code == 'invalid-verification-code') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Invalid OTP'),
// //         ),
// //       );
// //     } else if (error.code == 'session-expired') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Session Expired'),
// //         ),
// //       );
// //     } else if (error.code == 'user-not-found') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('Email not found, Kindly register first'),
// //         ),
// //       );
// //     } else if (error.code == 'wrong-password') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Incorrect password')),
// //       );
// //     } else if (error.code == 'weak-password') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Password is too weak')),
// //       );
// //     } else if (error.code == 'email-already-in-use') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('User already exists')),
// //       );
// //     } else if (error.code == 'invalid-email') {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Invalid email')),
// //       );
// //     } else {
// //       if (kDebugMode) {
// //         print(error.message);
// //       }
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Something went wrong')),
// //       );
// //     }
// //   }
// }

// void showCircularProgressIndicator(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     },
//   );
// }
// // }
