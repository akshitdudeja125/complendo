import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/providers/auth_provider.dart';
import 'package:complaint_portal/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider.autoDispose((ref) async {
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
final currentUserDataProvider = FutureProvider.autoDispose((ref) async {
  if (ref.read(currentUserProvider).value == null) {
    throw Exception('No user signed in');
  }
  final user = ref.read(fireBaseAuthProvider).currentUser!;
  final docSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  return docSnapshot.data();
});

final currentUserDataStreamProvider =
    StreamProvider.autoDispose<DocumentSnapshot>((ref) {
  final user = ref.read(fireBaseAuthProvider).currentUser!;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .snapshots();
});
final userDataProvider = StreamProvider<Map?>((ref) {
  final userStream = ref.watch(authStateProvider);
  return userStream.when(
    data: (user) {
      if (user == null) return const Stream.empty();
      // return FirebaseFirestore.instance
      return ref
          .watch(fireBaseFirestoreProvider)
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((event) => event.data());
    },
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
  );
});

Future<void> deleteComplaint(String cid, ref) async {
  final user = ref.read(fireBaseAuthProvider).currentUser!;
  final firestore = ref.watch(fireBaseFirestoreProvider);
  await firestore.collection('complaints').doc(cid).delete();
  // find the complaint in the user's complaints list and remove it if it exists
  await firestore.collection('users').doc(user.uid).update({
    'complaints': FieldValue.arrayRemove([cid])
  });
}
