import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final complaintStreamProvider =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, segment) {
  final user = ref.watch(authUserProvider)!;
  final firestore = ref.watch(firebaseFirestoreProvider);
  late Query query;

  switch (segment) {
    case "Open":
      query = firestore
          .collection('complaints')
          .where('uid', isEqualTo: user.uid)
          .where('status', isEqualTo: "pending")
          .orderBy('date', descending: false);
      break;
    case "Closed":
      query = firestore
          .collection('complaints')
          .where('status', isEqualTo: "resolved")
          .where('uid', isEqualTo: user.uid);
      break;
    case "All":
      query = firestore.collection('complaints');
      break;
    default:
      query = FirebaseFirestore.instance.collection('complaints');
  }

  return query.snapshots();
});

class FirebaseStorageRepository {
  Future<String?> getDownloadURL(ref, String cid, image) async {
    if (image == null) {
      return null;
    }
    String? downloadURL;
    final firebaseStorage = ref.watch(firebaseStorageProvider);
    final storageReference =
        firebaseStorage.ref().child('complaints/complaint_$cid.jpg');
    final uploadTask = storageReference.putFile(
      image,
    );
    await uploadTask.whenComplete(() async {
      downloadURL = await storageReference.getDownloadURL();
    });
    return downloadURL;
  }
}

final firebaseStorageRepositoryProvider =
    Provider<FirebaseStorageRepository>((ref) => FirebaseStorageRepository());

class ComplaintRepository {
  Future<void> deleteComplaint(String cid, ref) async {
    final user = ref.read(firebaseAuthProvider).currentUser!;
    final firestore = ref.watch(firebaseFirestoreProvider);
    await firestore.collection('complaints').doc(cid).delete();
    await firestore.collection('users').doc(user.uid).update({
      'complaints': FieldValue.arrayRemove([cid])
    });
  }

  Future<void> registerComplaint(ref, Complaint complaint) async {
    final user = ref.read(firebaseAuthProvider).currentUser!;
    final firestore = ref.watch(firebaseFirestoreProvider);
    await firestore.collection('complaints').doc(complaint.cid).set(
          complaint.toMap(),
        );
    await firestore.collection('users').doc(user.uid).update({
      'complaints': FieldValue.arrayUnion([complaint.cid])
    });
    await displaySnackBar('Success', 'Complaint Registered');
  }

  Future<void> updateComplaint(ref, Complaint complaint) async {
    final firestore = ref.read(firebaseFirestoreProvider);
    await firestore.collection('complaints').doc(complaint.cid).set({}
        // complaint.toMap(),
        ).whenComplete(() {
      displaySnackBar('Success', 'Complaint Updated');
    }).catchError((e) {
      displaySnackBar('Error', e.toString());
    });
  }
}

final complaintRepositoryProvider = Provider.autoDispose(
  (ref) => ComplaintRepository(),
);

final singleComplaintStreamProvider =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, cid) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final query = firestore.collection('complaints').where('cid', isEqualTo: cid);
  return query.snapshots();
});
