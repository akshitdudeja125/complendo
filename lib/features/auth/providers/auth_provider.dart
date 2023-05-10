import 'package:complaint_portal/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authRepositoryProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChange;
});

final authUserProvider = Provider<User?>((ref) {
  final userStream = ref.watch(authStateProvider);
  final user = userStream.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
  if (user != null) {
    return user;
  } else {
    return null;
  }
});
