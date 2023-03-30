import 'package:complaint_portal/providers/auth_provider.dart';
import 'package:complaint_portal/providers/firebase_instance_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataStreamProvider =
    FutureProvider.autoDispose.family((ref, String uid) async {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
      .collection('users')
      .doc(uid)
      .get()
      .then((value) => value.data());
});

final userDataProvider = Provider.family((ref, String uid) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore
      .collection('users')
      .doc(uid)
      .get()
      .then((value) => value.data());
});

final firebaseAuthUser = FutureProvider.autoDispose((ref) async {
  final userStream = ref.watch(authStateProvider);
  final user = userStream.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
  if (user != null) {
    return user;
  } else {
    throw Exception('No user signed in');
  }
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
