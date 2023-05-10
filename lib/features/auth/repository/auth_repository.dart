// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/features/auth/repository/user_repository.dart';
import 'package:complaint_portal/features/landing/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<bool> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return true;
    }).catchError((error) {
      debugPrint(error.toString());
      // return false;
    });
    return false;
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _auth.signInWithCredential(credential).then((value) {
        return true;
      }).onError((error, stackTrace) {
        debugPrint("Error -e : $error");
        return false;
      });
      return true;
    } catch (e) {
      debugPrint("Error -e : $e");
      return false;
    }
  }

  Future<bool> signOut(WidgetRef ref) async {
    try {
      debugPrint("signing out");
      final uid = _auth.currentUser!.uid;

      final UserRepository userRepo = ref.watch(userRepositoryProvider);
      await _auth.signOut();
      await _googleSignIn.signOut();
      ref.watch(isTermsCheckedProvider.notifier).state = false;
      await userRepo.deleteToken(
        uid,
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
