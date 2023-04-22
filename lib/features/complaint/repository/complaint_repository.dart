import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/common/services/notifications/notification_service.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

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

  Future<bool> updateComplaint(ref, Complaint complaint) async {
    final firestore = ref.read(firebaseFirestoreProvider);
    bool isUpdated = false;
    await firestore
        .collection('complaints')
        .doc(complaint.cid)
        .set(
          complaint.toMap(),
        )
        .whenComplete(() {
      isUpdated = true;
    }).catchError((e) {
      displaySnackBar('Error', e.toString());
    });
    return isUpdated;
  }

  void changeComplaintStatus(
      {required Complaint complaint,
      required WidgetRef ref,
      String? comment,
      String? resolvedBy,
      required String to}) {
    if (to == 'rejected') {
      FirebaseFirestore.instance
          .collection('complaints')
          .doc(complaint.cid)
          .update(
            complaint
                .copyWith(
                  status: 'rejected',
                  resolvedBy: null,
                  comment: comment,
                )
                .toMap(),
          );
      final receiver = complaint.uid;
      final recieverToken = FirebaseFirestore.instance
          .collection('users')
          .doc(receiver)
          .get()
          .then((value) => value.data()!['deviceToken']);
      recieverToken.then((value) {
        NotificationService().sendNotifcationToUser(
          reciever: value,
          title: 'Complaint Rejected',
          body: 'Your complaint has been rejected',
          cid: complaint.cid,
        );
        Get.back();
      });
    }
    if (to == 'resolved') {
      FirebaseFirestore.instance
          .collection('complaints')
          .doc(complaint.cid)
          .update(complaint
              .copyWith(
                status: 'resolved',
                resolvedBy: resolvedBy,
                comment: comment,
                resolvedAt: DateTime.now(),
              )
              .toMap());
      final receiver = complaint.uid;
      final recieverToken = FirebaseFirestore.instance
          .collection('users')
          .doc(receiver)
          .get()
          .then((value) => value.data()!['deviceToken']);
      recieverToken.then((value) {
        NotificationService().sendNotifcationToUser(
          reciever: value,
          title: 'Complaint Resolved',
          body: 'Your complaint has been resolved',
          cid: complaint.cid,
        );
        Get.back();
      });
    }
    if (to == 'pending') {
      FirebaseFirestore.instance
          .collection('complaints')
          .doc(complaint.cid)
          .update(
            complaint
                .copyWith(
                  status: 'pending',
                  resolvedBy: null,
                  comment: null,
                  resolvedAt: null,
                )
                .toMap(),
          );
    }
  }
}

final complaintRepositoryProvider = Provider.autoDispose(
  (ref) => ComplaintRepository(),
);

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
