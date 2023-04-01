import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/constants.dart';
import '../auth/repository/auth_repository.dart';

class StudentProfile extends ConsumerWidget {
  // final Map<String, dynamic> userData;
  final UserModel user;
  const StudentProfile({
    super.key,
    required this.user,
    // required this.userData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        // if (userData['photoURL'] != null)
        if (user.photoURL != null)
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              // userData['photoURL'],
              user.photoURL!,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: kDefaultSpacing / 2),
          child: Text(
            // userData['name'],
            user.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultSpacing / 2),
          child: Text(
            // userData['rollNo'],
            user.rollNo!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        GestureDetector(
          onTap: () => AuthService().signOut(ref),
          child: const Chip(
            label: Text("Log out"),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: "Name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            try {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({
                'name': nameController.text,
              });
            } catch (e) {
              print(e);
            }
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}
