import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataStreamProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>?, String?>((ref, uid) {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);

  var value = firebaseInstance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((event) => event.data());
  return value;
});

final userModelProvider = Provider.autoDispose<UserModel>((ref) {
  final userData =
      ref.watch(userDataStreamProvider(FirebaseAuth.instance.currentUser!.uid));
  return userData.when(
    data: (data) {
      return UserModel.fromMap(data!);
    },
    loading: () => UserModel(
      id: '',
      email: '',
      name: '',
    ),
    error: (_, __) => UserModel(
      id: '',
      email: '',
      name: '',
    ),
  );
});
