import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final complaintFromSegmentStreamProvider =
//     StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, segment) {
//   final user = ref.watch(authUserProvider)!;
//   final firestore = ref.watch(firebaseFirestoreProvider);
//   late Query query;

//   switch (segment) {
//     case "Pending":
//       query = firestore
//           .collection('complaints')
//           .where('uid', isEqualTo: user.uid)
//           .where('status', isEqualTo: "pending")
//           .orderBy('date', descending: false);
//       break;
//     case "Resolved":
//       query = firestore
//           .collection('complaints')
//           .where('uid', isEqualTo: user.uid)
//           .where('status', isEqualTo: "resolved");
//       break;
//     case "Rejected":
//       query = firestore
//           .collection('complaints')
//           .where('uid', isEqualTo: user.uid)
//           .where('status', isEqualTo: "rejected");
//       break;
//     case "All":
//       query = firestore.collection('complaints');
//       break;
//     default:
//       query = FirebaseFirestore.instance.collection('complaints');
//   }

//   return query.snapshots();
// });

// final complaintListProvider =
//     Provider.family.autoDispose<List<Complaint>, String>((ref, segment) {
//   final complaintData = ref.watch(complaintFromSegmentStreamProvider(segment));
//   return complaintData.when(
//     data: (data) {
//       return data.docs.map((e) => Complaint.fromObject(e.data())).toList();
//     },
//     loading: () => [],
//     error: (_, __) => [],
//   );
// });

final pendingRequestsProvider = StreamProvider.autoDispose<int>((ref) {
  final user = ref.watch(userProvider);
  return FirebaseFirestore.instance
      .collection('complaints')
      .where('status', isEqualTo: 'pending')
      .where('uid', isEqualTo: user.id)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
          .where((element) => element['status'] == 'pending')
          .length);
});

final complaintDataStreamProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>?, String?>((ref, cid) {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);
  var value = firebaseInstance
      .collection('complaints')
      .doc(cid)
      .snapshots()
      .map((event) => event.data());
  return value;
});

final complaintProvider =
    Provider.autoDispose.family<Complaint, String>((ref, cid) {
  final complaintData = ref.watch(complaintDataStreamProvider(cid));
  return complaintData.when(
    data: (data) {
      return Complaint.fromObject(data!);
    },
    loading: () => Complaint(),
    error: (_, __) => Complaint(),
  );
});

final complaintStreamProvider =
    StreamProvider.autoDispose<List<Complaint>>((ref) {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);
  // final user = ref.watch(authUserProvider)!;
  return firebaseInstance
      .collection('complaints')
      // .where('uid', isEqualTo: user.uid)
      .snapshots()
      .map((event) {
    return event.docs.map((e) => Complaint.fromObject(e.data())).toList();
  });
});

final complaintListProvider = Provider.autoDispose<List<Complaint>>((ref) {
  final complaintData = ref.watch(complaintStreamProvider);
  return complaintData.when(
    data: (data) {
      return data;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final myComplaintStreamProvider =
    StreamProvider.autoDispose<List<Complaint>>((ref) {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);
  final user = ref.watch(authUserProvider)!;
  return firebaseInstance
      .collection('complaints')
      .where('uid', isEqualTo: user.uid)
      .snapshots()
      .map((event) {
    return event.docs.map((e) => Complaint.fromObject(e.data())).toList();
  });
});

final myComplaintListProvider = Provider.autoDispose<List<Complaint>>((ref) {
  final complaintData = ref.watch(myComplaintStreamProvider);
  return complaintData.when(
    data: (data) {
      return data;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
