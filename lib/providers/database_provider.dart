// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'auth_provider.dart';

// class Database {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late CollectionReference _usersCollectionReference;
//   Stream get users => _firestore.collection("users").snapshots();

//   Database() {
//     _usersCollectionReference = _firestore.collection("users");
//   }

//   Future<void> addUser(
//       String uid, String? displayName, String? email, String? photoURL) async {
//     _usersCollectionReference.doc(uid).get().then((value) {
//       if (!value.exists) {
//         try {
//           _usersCollectionReference.doc(uid).set({
//             'id': uid,
//             'name': displayName!,
//             'email': email!,
//             'photoURL': photoURL!,
//             'isProfileComplete': false,
//             'isAdmin': false,
//           });
//         } catch (e) {
//           rethrow;
//         }
//       }
//     });
//   }
//   // Future<void> updateUser(
//   //   String uid, String? displayName, String? email, String? photoURL
//   // ){
    
//   // }
// }

// final databaseProvider = Provider<Database>((ref) {
//   return Database();
// });

// final dataProvider = StreamProvider<Map?>((ref) {
//   final userStream = ref.watch(authStateProvider);
//   return userStream.when(
//     data: (user) {
//       return FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .snapshots()
//           .map((event) => event.data());
//     },
//     loading: () => const Stream.empty(),
//     error: (_, __) => const Stream.empty(),
//   );
// });
