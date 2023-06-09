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

//provider to get a list of all users in the firebase
final allUsersStreamProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>?>((ref) {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);

  var value = firebaseInstance
      .collection('users')
      .snapshots()
      .map((event) => event.docs.map((e) => e.data()).toList());
  return value;
});

//provider to get a list of all users in the firebase
final allUsersProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>?>((ref) async {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);

  var value = await firebaseInstance
      .collection('users')
      .get()
      .then((value) => value.docs.map((e) => e.data()).toList());
  return value;
});

final userProvider = Provider.autoDispose<UserModel>((ref) {
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
final firebaseDataProvider = Provider.autoDispose((ref) {
  final userData =
      ref.watch(userDataStreamProvider(FirebaseAuth.instance.currentUser!.uid));
  return userData.when(
    data: (data) {
      return data;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

final complaintUserProvider =
    Provider.family.autoDispose<UserModel, String>((ref, uid) {
  final userData = ref.watch(userDataStreamProvider(uid));
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
