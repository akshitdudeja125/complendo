import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});
final fireBaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// create a provider for the current user firestore data until the user is logged in
final currentUserDataProvider = FutureProvider((ref) async {
  final user = ref.read(fireBaseAuthProvider).currentUser!;
  final docSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  return docSnapshot.data();
});

// create a provider for the current user Firebaseauth data until the user is logged in
final currentUserProvider = FutureProvider((ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return user;
  } else {
    throw Exception('No user signed in');
  }
});
