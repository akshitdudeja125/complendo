// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_portal/constants.dart';
// import 'package:complaint_portal/widgets/custom_appbar.dart';
// import 'package:complaint_portal/widgets/bottom_navbar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});

//   @override
//   ConsumerState<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage> {
//   final user = FirebaseAuth.instance.currentUser;
//   int currentIndex = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(
//     BuildContext context,
//   ) {
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
//           key: _scaffoldKey,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/bottom_navbar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(dataProvider);
    return data.when(
      data: (data) {
        void onTapped(int index) {
          setState(() {
            currentIndex = index;
          });
        }

        return Scaffold(
          body: (data!['isAdmin'])
              ? adminPages[currentIndex]
              : userPages[currentIndex],
          bottomNavigationBar: BottomBar(
            currentIndex: currentIndex,
            data: data,
            onTap: onTapped,
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
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../providers/auth_provider.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage> {
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     final auth = ref.watch(authenticationProvider);
//     final data = ref.watch(dataProvider);
//     return data.when(
//       data: (data) {
//         void onTapped(int index) {
//           setState(() {
//             currentIndex = index;
//           });
//         }

//         return Scaffold(
//           body: SafeArea(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   // child: Text(data.currentUser!.email ?? 'You are logged In'),
//                   child: Text(data!['name']),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(data['email']),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(data['id'] ?? ''),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(top: 48.0),
//                   margin: const EdgeInsets.symmetric(horizontal: 16),
//                   width: double.infinity,
//                   child: MaterialButton(
//                     onPressed: () => auth.signOut(),
//                     textColor: Colors.blue.shade700,
//                     textTheme: ButtonTextTheme.primary,
//                     minWidth: 100,
//                     padding: const EdgeInsets.all(18),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                       side: BorderSide(color: Colors.blue.shade700),
//                     ),
//                     child: const Text(
//                       'Log Out',
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//       error: (error, stack) => const Center(
//         child: Text('Something went wrong'),
//       ),
//     );
//   }
// }
