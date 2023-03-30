import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/providers/firebase_instance_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = StreamProvider.autoDispose((ref) {
  // check if user is logged in
  final user = ref.watch(authUserProvider);
  if (user == null) {
    return const Stream.empty();
  }
  final uid = user.uid;
  final firestore = ref.watch(firebaseFirestoreProvider);
  return firestore.collection('users').doc(uid).snapshots();
});
