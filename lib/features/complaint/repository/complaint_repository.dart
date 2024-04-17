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

  Future<void> downVoteComplaint(String cid, ref) async {
    try {
      final user = ref.read(firebaseAuthProvider).currentUser!;
      final firestore = ref.watch(firebaseFirestoreProvider);

      final docRef = firestore.collection('complaints').doc(cid);
      final docSnapshot = await docRef.get();
      // Update votes collection based on the complaint's upvote status

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> downvotes = data['downvotes'] ?? [];

        if (downvotes.contains(user.uid)) {
          // User has already downvoted, remove the downvote
          await docRef.update({
            'downvotes': FieldValue.arrayRemove([user.uid]),
          });
        } else {
          // User hasn't downvoted, add the downvote
          await docRef.update({
            'downvotes': FieldValue.arrayUnion([user.uid]),
            'upvotes': FieldValue.arrayRemove([user.uid]),
          });
        }
      } else {
        throw 'Complaint not found';
      }
      final votesRef = firestore.collection('votes').doc(cid);
      final votesSnapshot = await votesRef.get();
      if (votesSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> downvotes = data['downvotes'] ?? [];

        if (downvotes.contains(user.uid)) {
          // User has already downvoted, remove the downvote
          await votesRef.update({
            'downvotes': FieldValue.arrayRemove([user.uid]),
          });
        } else {
          // User hasn't downvoted, add the downvote
          await votesRef.update({
            'downvotes': FieldValue.arrayUnion([user.uid]),
            'upvotes': FieldValue.arrayRemove([user.uid]),
          });
        }
      } else {
        await votesRef.set({
          'downvotes': FieldValue.arrayUnion([user.uid]),
        });
      }
    } catch (e) {
      print(e);
      displaySnackBar('Error', 'Error toggling downvote for complaint');
    }
  }

  Future<void> upvoteComplaint(String cid, ref) async {
    try {
      final user = ref.read(firebaseAuthProvider).currentUser!;
      final firestore = ref.watch(firebaseFirestoreProvider);

      final docRef = firestore.collection('complaints').doc(cid);
      final docSnapshot = await docRef.get();

      final votesRef = firestore.collection('votes').doc(cid);

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> upvotes = data['upvotes'] ?? [];

        if (upvotes.contains(user.uid)) {
          // User has already downvoted, remove the downvote
          await docRef.update({
            'upvotes': FieldValue.arrayRemove([user.uid]),
          });
        } else {
          // User hasn't downvoted, add the downvote
          await docRef.update({
            'upvotes': FieldValue.arrayUnion([user.uid]),
            'downvotes': FieldValue.arrayRemove([user.uid]),
          });
        }
      } else {
        throw 'Complaint not found';
      }
      final votesSnapshot = await votesRef.get();
      if (votesSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final List<dynamic> upvotes = data['upvotes'] ?? [];

        if (upvotes.contains(user.uid)) {
          // User has already downvoted, remove the downvote
          await votesRef.update({
            'upvotes': FieldValue.arrayRemove([user.uid]),
          });
        } else {
          // User hasn't downvoted, add the downvote
          await votesRef.update({
            'upvotes': FieldValue.arrayUnion([user.uid]),
            'downvotes': FieldValue.arrayRemove([user.uid]),
          });
        }
      } else {
        await votesRef.set({
          'upvotes': FieldValue.arrayUnion([user.uid]),
        });
      }
    } catch (e) {
      print(e);
      displaySnackBar('Error', 'Error toggling upvote for complaint');
    }
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
      Get.back();
      final receiver = complaint.uid;
      final recieverToken = FirebaseFirestore.instance
          .collection('users')
          .doc(receiver)
          .get()
          .then((value) {
        print({"valuefromrecievertoken": value.data()});
        // return value.data()!['deviceToken'];
        //check if the reciever has notifcation as enabled
        print(value.data()!['notifications']);
        print(value.data()!['deviceToken']);
        if (value.data()!['notifications'] == true) {
          return value.data()!['deviceToken'];
        }
        print({
          'recieverToken': value.data()!['deviceToken'],
          'notifcations': value.data()!['notifications']
        });
        return null;
      });
      recieverToken.then((value) {
        //check if the reciever has notifcation as enabled
        NotificationService().sendNotifcationToUser(
          reciever: value,
          title: 'Complaint Rejected',
          body: 'Your complaint has been rejected',
          cid: complaint.cid,
        );
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
      Get.back();
      print("resolved");
      final receiver = complaint.uid;
      print({receiver});
      final recieverToken = FirebaseFirestore.instance
          .collection('users')
          .doc(receiver)
          .get()
          .then((value) {
        print({"valuefromrecievertoken": value.data()});
        // return value.data()!['deviceToken'];
        //check if the reciever has notifcation as enabled
        print(value.data()!['notifications']);
        print(value.data()!['deviceToken']);
        if (value.data()!['notifications'] == true) {
          return value.data()!['deviceToken'];
        }
        print({
          'recieverToken': value.data()!['deviceToken'],
          'notifcations': value.data()!['notifications']
        });
        return null;
      });
      print({recieverToken});
      recieverToken.then((value) {
        print({"recieverToken": recieverToken});
        print({
          'reciever': value,
          'title': 'Complaint Resolved',
          'body': 'Your complaint has been resolved',
          'cid': complaint?.cid,
        });
        NotificationService().sendNotifcationToUser(
          reciever: value,
          title: 'Complaint Resolved',
          body: 'Your complaint has been resolved',
          cid: complaint.cid,
        );
        print("resolved and sent notification");
      }).onError((error, stackTrace) {
        print({"error": error, "stackTrace": stackTrace});
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
