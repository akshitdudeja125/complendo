import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository());

class UserRepository {
  Future<void> setUser(
    UserModel user,
  ) async {
    final db = FirebaseFirestore.instance.collection('users');
    await db.doc(user.id).set(user.toMap());
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

  void updateToken(token, String uid) {
    FirebaseFirestore.instance.collection('users').doc(uid).update(
      {'token': token},
    );
    FirebaseFirestore.instance.collection('tokens').doc(uid).set(
      {'token': token, 'uid': uid},
    );

  }
}
