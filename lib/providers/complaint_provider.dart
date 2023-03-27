import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/providers/auth_provider.dart';
import 'package:complaint_portal/providers/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final complaintStreamProvider =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, segment) {
  final user = ref.watch(currentUserProvider).value!;
  final firestore = ref.watch(fireStoreInstanceProvider);
  late Query query;

  switch (segment) {
    case "Open":
      query = firestore
          .collection('complaints')
          .where('uid', isEqualTo: user.uid)
          .where('status', isEqualTo: "Pending");
      break;
    case "Closed":
      query = firestore
          .collection('complaints')
          .where('status', isEqualTo: "Closed")
          .where('uid', isEqualTo: user.uid);
      break;
    case "All":
      query =
          firestore.collection('complaints').where('uid', isEqualTo: user.uid);
      break;
    default:
      query = FirebaseFirestore.instance.collection('complaints');
  }

  return query.snapshots();
});

// final singleComplaintStreamProvider =
//     StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, id) {
//   final firestore = ref.watch(fireStoreInstanceProvider);
//   final query = firestore.collection('complaints').where('id', isEqualTo: id);
//   return query.snapshots();
// });
