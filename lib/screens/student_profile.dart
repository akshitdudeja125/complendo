import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/providers/database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../services/auth_service.dart';
import '../widgets/clipper.dart';
import 'package:intl/intl.dart';

import '../widgets/complaint_card.dart';

// class SettingsTile extends StatelessWidget {
//   final String title;
//   final String imageUrl;
//   String? subtitle;
//   SettingsTile({
//     super.key,
//     required this.title,
//     this.subtitle = "",
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Padding(
//         padding: subtitle == ""
//             ? const EdgeInsets.symmetric(horizontal: 8)
//             : const EdgeInsets.all(8),
//         child: Image.asset(imageUrl),
//       ),
//       title: Text(
//         title,
//         style: Theme.of(context).textTheme.titleMedium,
//       ),
//       subtitle: Text(
//         subtitle ?? "",
//         style: Theme.of(context).textTheme.titleSmall!.copyWith(
//             // color: fontHeading,
//             ),
//       ),
//       trailing: const Padding(
//         padding: EdgeInsets.symmetric(horizontal: defaultSpacing),
//         child: Icon(
//           Icons.arrow_forward_ios_rounded,
//           size: 20,
//           color: Colors.black26,
//         ),
//       ),
//     );
//   }
// }

// ignore: must_be_immutable
class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late final List<String> _segments;
  late final ValueNotifier<int> _selectedSegmentIndex;
  late final Stream<QuerySnapshot> _complaintStream;

  @override
  void initState() {
    super.initState();
    _segments = ["Open", "All", "Closed"];
    _selectedSegmentIndex = ValueNotifier<int>(0);
    _complaintStream =
        _getComplaintStream(_segments[_selectedSegmentIndex.value]);
  }

  Stream<QuerySnapshot> _getComplaintStream(String segment) {
    if (segment == "Open") {
      return FirebaseFirestore.instance
          .collection('complaints')
          .where('status', isEqualTo: "Pending")
          .snapshots();
    } else if (segment == "Closed") {
      return FirebaseFirestore.instance
          .collection('complaints')
          .where('uid', isEqualTo: "Closed")
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('complaints').snapshots();
    }
  }

  @override
  void dispose() {
    _selectedSegmentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;
        // print(data);
        return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            if (data['photoURL'] != null)
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  data['photoURL'],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: defaultSpacing / 2),
              child: Text(
                data['name'],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: defaultSpacing / 2),
              child: Text(
                data['rollNo'],
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            GestureDetector(
              onTap: () => AuthService().signOut(),
              child: const Chip(
                label: Text("Log out"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
