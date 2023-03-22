// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../services/auth_service.dart';

// class StudentProfile extends StatefulWidget {
//   const StudentProfile({super.key});

//   @override
//   State<StudentProfile> createState() => _StudentProfileState();
// }

// class _StudentProfileState extends State<StudentProfile> {
//   final userId = FirebaseAuth.instance.currentUser!.uid;
//   final CollectionReference _usersCollectionReference =
//       FirebaseFirestore.instance.collection('users');
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               AuthService().signOut();
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: _usersCollectionReference.doc(userId).snapshots(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final data = snapshot.data!.data() as Map<String, dynamic>;
//           print(data);
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(
//                       data['photoURL'] ?? "https://i.pravatar.cc/150"),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Welcome ${data['name']}',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Type: ${data['type']}',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'User Id: ${data['id']}',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 Text(
//                   'Admin : ${data['isAdmin']}',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Email: ${data['email']}',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Phone: ${data['phoneNumber']}',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Email Verified: ${data['emailVerified']}',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/providers/database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../services/auth_service.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _usersCollectionReference.doc(userId).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(defaultSpacing),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(
                              data['photoURL'] ?? "",
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: defaultSpacing / 2),
                            child: Text(
                              data['name'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: defaultSpacing / 2),
                            child: Text(
                              data['email'],
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => AuthService().signOut(),
                            child: const Chip(
                              label: Text("Log out"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingsTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  String? subtitle;
  SettingsTile({
    super.key,
    required this.title,
    this.subtitle = "",
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: subtitle == ""
            ? const EdgeInsets.symmetric(horizontal: 8)
            : const EdgeInsets.all(8),
        child: Image.asset(imageUrl),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle ?? "",
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            // color: fontHeading,
            ),
      ),
      trailing: const Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultSpacing),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20,
          color: Colors.black26,
        ),
      ),
    );
  }
}
