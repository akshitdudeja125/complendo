import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});
