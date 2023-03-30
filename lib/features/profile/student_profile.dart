import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/constants.dart';
import '../auth/repository/auth_repository.dart';

class StudentProfile extends ConsumerWidget {
  final Map<String, dynamic> userData;
  const StudentProfile({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        if (userData['photoURL'] != null)
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              userData['photoURL'],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: defaultSpacing / 2),
          child: Text(
            userData['name'],
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: defaultSpacing / 2),
          child: Text(
            userData['rollNo'],
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
