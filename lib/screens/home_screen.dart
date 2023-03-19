// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_portal/constants.dart';
// import 'package:complaint_portal/widgets/custom_appbar.dart';
// import 'package:complaint_portal/widgets/bottom_navbar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../providers/auth_provider.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage> {
//   final user = FirebaseAuth.instance.currentUser;
//   int currentIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context,) {
//     final data = ref.watch(fireBaseAuthProvider);

//     //  Second variable to access the Logout Function
//     final auth = ref.watch(authenticationProvider);
//     return FutureBuilder(
//       future:
//           FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         void onTapped(int index) {
//           setState(() {
//             currentIndex = index;
//           });
//         }

//         final data = snapshot.data!.data() as Map<String, dynamic>;
//         return Scaffold(
//           // appBar: TopBar(
//           //   avatarImage: user!.photoURL,
//           // ),
//           appBar: AppBar(
//             title: const Text('Complaint Portal'),
//             actions: [
//               IconButton(
//                   onPressed: () {
// // sign out
//                   },
//                   icon: const Icon(Icons.logout)),
//             ],
//           ),
//           key: _scaffoldKey,
//           // appBar: TopBar(
//           //   avatarImage: user!.photoURL,
//           // ),
//           body: (data['isAdmin'])
//               ? adminPages[currentIndex]
//               : userPages[currentIndex],
//           bottomNavigationBar: BottomBar(
//             currentIndex: currentIndex,
//             data: data,
//             onTap: onTapped,
//           ),
//           // bottomNavigationBar:
//           // bottomBar(currentIndex: currentIndex, data: data),
//         );
//       },
//     );
//   }
// }

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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // first variable is to get the data of Authenticated User
    final auth = ref.watch(authenticationProvider);
    final data = ref.watch(dataProvider);
    print(data);
    return data.when(
      data: (data) {
        // print(data);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: Text(data.currentUser!.email ?? 'You are logged In'),
                  child: Text(data!['name']),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['email']),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['id'] ?? ''),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 48.0),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () => auth.signOut(),
                    textColor: Colors.blue.shade700,
                    textTheme: ButtonTextTheme.primary,
                    minWidth: 100,
                    padding: const EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.blue.shade700),
                    ),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => const Center(
        child: Text('Something went wrong'),
      ),
    );
  }
  // )
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(data.currentUser!.email ?? 'You are logged In'),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(data.currentUser!.displayName ??
  //                 ' Great you have Completed this step'),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.only(top: 48.0),
  //             margin: const EdgeInsets.symmetric(horizontal: 16),
  //             width: double.infinity,
  //             child: MaterialButton(
  //               onPressed: () => auth.signOut(),
  //               textColor: Colors.blue.shade700,
  //               textTheme: ButtonTextTheme.primary,
  //               minWidth: 100,
  //               padding: const EdgeInsets.all(18),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(25),
  //                 side: BorderSide(color: Colors.blue.shade700),
  //               ),
  //               child: const Text(
  //                 'Log Out',
  //                 style: TextStyle(fontWeight: FontWeight.w600),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  // }
}
