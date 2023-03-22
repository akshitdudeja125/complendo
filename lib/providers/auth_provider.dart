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
final dataProvider = StreamProvider<Map?>((ref) {
  final userStream = ref.watch(authStateProvider);
  return userStream.when(
    data: (user) {
      if (user == null) return const Stream.empty();
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((event) => event.data());
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});
