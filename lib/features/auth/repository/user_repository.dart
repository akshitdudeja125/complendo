import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref: ref));

class UserRepository {
  final ProviderRef ref;

  const UserRepository({
    required this.ref,
  });

  Future<void> setUser(
    UserModel user,
  ) async {
    final db = FirebaseFirestore.instance.collection('users');
    await db.doc(user.id).set(
          user.toMap(),
        );
  }

  Future<void> updateUserField(
    String docId,
    String field,
    value,
  ) async {
    FirebaseFirestore.instance.collection('users').doc(docId).update(
      {field: value},
    );
  }

  Future<void> deleteToken(String uid) async {
    debugPrint('deleting token');
    await FirebaseFirestore.instance.collection('tokens').doc(uid).delete();
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
      {'deviceToken': FieldValue.delete()},
    );
    debugPrint('token deleted');
  }

  void updateToken(token, String uid) {
    final instance = ref.watch(firebaseFirestoreProvider);
    instance.collection('users').doc(uid).update(
      {'deviceToken': token},
    );
    instance.collection('tokens').doc(uid).set(
      {'deviceToken': token, 'uid': uid},
    );
  }
}
