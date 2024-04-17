import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pendingRequestsProvider = StreamProvider.autoDispose<int>((ref) {
  final user = ref.watch(userProvider);
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);
  return firebaseInstance
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
      if (data == null) {
        return Complaint();
      }
      return Complaint.fromObject(data);
    },
    loading: () => Complaint(),
    error: (_, __) => Complaint(),
  );
});

final complaintStreamProvider =
    StreamProvider.autoDispose<List<Complaint>>((ref) {
  final firebaseInstance = ref.watch(firebaseFirestoreProvider);
  return firebaseInstance.collection('complaints').snapshots().map((event) {
    return event.docs.map((e) {
      // print("events");
      // print({e: e.data()});
      return Complaint.fromObject(e.data());
    }).toList();
  });
});

final complaintListProvider = Provider.autoDispose<List<Complaint>>((ref) {
  final complaintData = ref.watch(complaintStreamProvider);
  // print({"complaintData": complaintData});
  return complaintData.when(
    data: (data) {
      // print({
      //   data: {data}
      // });
      return data;
    },
    loading: () => [],
    error: (_, __) {
      print({"Error in complaintListProvider": _});
      return [];
    },
  );
});
