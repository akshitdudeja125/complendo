import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
// import 'package:get/get.dart';

// Create provider for db

class UserRepository {
  final _db = FirebaseFirestore.instance.collection('users');
  createUser(
    String uid,
    String? displayName,
    String? email,
    String? photoURL,
  ) {
    _db.doc(uid).get().then((value) {
      if (!value.exists) {
        try {
          _db.doc(uid).set(UserModel(
                id: uid,
                name: displayName!,
                email: email!,
                photoURL: photoURL!,
                isProfileComplete: false,
                isAdmin: false,
              ).toMap());
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
    _db.doc(uid).get().then((value) {
      if (value.exists) {
        try {
          _db.doc(uid).update(UserModel(
                id: uid,
                name: value.data()!['name'],
                email: value.data()!['email'],
                photoURL: value.data()!['photoURL'],
                isProfileComplete: true,
                isAdmin: false,
                hostel: hostel!,
                phoneNumber: phoneNumber!,
                roomNo: roomNo!,
                rollNo: rollNo!,
              ).toMap());
        } catch (e) {
          rethrow;
        }
      }
    });
  }
}
