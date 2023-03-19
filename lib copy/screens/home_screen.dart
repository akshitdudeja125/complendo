import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/constants.dart';
import 'package:complaint_portal/widgets/custom_appbar.dart';
import 'package:complaint_portal/widgets/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        void onTapped(int index) {
          setState(() {
            currentIndex = index;
          });
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          key: _scaffoldKey,
          // appBar: TopBar(
          //   avatarImage: user!.photoURL,
          // ),
          body: (data['isAdmin'])
              ? adminPages[currentIndex]
              : userPages[currentIndex],
          bottomNavigationBar: BottomBar(
            currentIndex: currentIndex,
            data: data,
            onTap: onTapped,
          ),
          // bottomNavigationBar:
          // bottomBar(currentIndex: currentIndex, data: data),
        );
      },
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_portal/services/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
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
//               AuthService().signOut(
//                 context,
//               );
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
