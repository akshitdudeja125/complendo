import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
// import 'package:get/get.dart';

class UserRepository {
  final db = FirebaseFirestore.instance.collection('users');
  createUser(
      User user, String hostelName, String rollNumber, String room) async {
    try {
      await db.doc(user.uid).set(UserModel(
            name: user.displayName!,
            id: user.uid,
            isAdmin: false,
            email: user.email!,
            hostel: hostelName,
            rollNo: rollNumber,
            roomNo: room,
            photoURL: user.photoURL!,
          ).toMap());
    } catch (e) {
      return e;
    }
  }
}
