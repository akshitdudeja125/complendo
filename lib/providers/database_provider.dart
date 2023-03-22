import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/complaint_model.dart';
import '../models/user_model.dart';
import 'auth_provider.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _usersCollectionReference;
  late CollectionReference _complaintsCollectionReference;
  Stream get users => _firestore.collection("users").snapshots();
  StreamProvider<Map?> get dataProvider => StreamProvider<Map?>((ref) {
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
  Database() {
    if (kDebugMode) {
      print("Database initialized");
    }
    _usersCollectionReference = _firestore.collection("users");
    _complaintsCollectionReference = _firestore.collection("complaints");
  }

  Future<void> addUser(
      String uid, String? displayName, String? email, String? photoURL) async {
    _usersCollectionReference.doc(uid).get().then((value) {
      if (!value.exists) {
        try {
          _usersCollectionReference.doc(uid).set({
            'id': uid,
            'name': displayName!,
            'email': email!,
            'photoURL': photoURL!,
            'isProfileComplete': false,
            'isAdmin': false,
          });
        } catch (e) {
          rethrow;
        }
      }
    });
  }

  updateUser(
    String uid,
    String? rollNo,
    String? phoneNumber,
    String? hostel,
    String? roomNo,
  ) {
    _usersCollectionReference.doc(uid).get().then((value) {
      if (value.exists) {
        try {
          final data = value.data() as Map<String, dynamic>;
          _usersCollectionReference.doc(uid).update(UserModel(
                id: uid,
                email: data['email'],
                isProfileComplete: true,
                isAdmin: false,
                hostel: hostel!,
                phoneNumber: phoneNumber!,
                roomNo: roomNo!,
                rollNo: rollNo!,
                name: '',
              ).toMap());
        } catch (e) {
          rethrow;
        }
      }
    });
  }

  addComplaint(
    String uid,
    String? rollNo,
    String? phoneNumber,
    String? roomNo,
    String? complaint,
  ) {
    _complaintsCollectionReference.add(
      Complaint(
        cid: '',
      ).toMap(),
    );
    // _usersCollectionReference.doc(uid).get().then((value) {
    //   if (value.exists) {
    //     try {
    //       final data = value.data() as Map<String, dynamic>;
    //       _usersCollectionReference.doc(uid).update(UserModel(

    //           ).toMap());
    //     } catch (e) {
    //       rethrow;
    //     }
    //   }
    // });
  }
}

final databaseProvider = Provider<Database>((ref) {
  return Database();
});
