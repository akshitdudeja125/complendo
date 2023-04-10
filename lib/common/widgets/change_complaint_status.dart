import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/services/notifications/notification_service.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void changeComplaintStaus(
  Complaint complaint,
  WidgetRef ref,
) {
  if (complaint.status == 'resolved') {
    FirebaseFirestore.instance
        .collection('complaints')
        .doc(complaint.cid)
        .update({'status': 'pending'});
  } else {
    FirebaseFirestore.instance
        .collection('complaints')
        .doc(complaint.cid)
        .update({'status': 'resolved'});
    final receiver = complaint.uid;
    final recieverToken = FirebaseFirestore.instance
        .collection('users')
        .doc(receiver)
        .get()
        .then((value) => value.data()!['token']);
    recieverToken.then((value) {
      NotificationService().sendNotifcationToUser(
        reciever: value,
        title: 'Complaint Resolved',
        body: 'Your complaint has been resolved',
      );

      Get.back();
    });
  }
}
