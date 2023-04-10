// ignore_for_file: unused_local_variable

import 'package:complaint_portal/common/services/connectivity_service.dart';
import 'package:complaint_portal/features/navigation/provider/page_controller_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/features/complaint/screen/provider/complaint_provider.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/form/providers/complaint_form_provider.dart';

void submitComplaint(ref, user) async {
  if (ref.watch(hostelProvider.notifier).state == null) {
    displaySnackBar('Error', 'Please select a hostel');
    return;
  }
  if (ref.watch(complaintCategoryProvider.notifier).state == null) {
    displaySnackBar('Error', 'Please select a complaint category');
    return;
  }
  if (!ref.watch(formKeyProvider.notifier).state.currentState!.validate()) {
    displaySnackBar('Error', 'Please fill all the fields');
    return;
  }

  if (!await checkConnectivity(ref)) return;

  showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      title: const Text('Submit Complaint'),
      content: const Text('Are you sure you want to submit this complaint?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            try {
              ref.watch(isLoadingProvider.notifier).state = true;
              displaySnackBar('Details Verified', 'Processing Data');
              final firestore = ref.watch(firebaseFirestoreProvider);
              final complaintId = firestore.collection('complaints').doc().id;
              String? downloadURL = await ref
                  .watch(firebaseStorageRepositoryProvider)
                  .getDownloadURL(
                      ref, complaintId, ref.watch(pickedImageProvider));
              final Complaint complaint = Complaint(
                uid: user.id,
                cid: complaintId,
                title: ref.watch(titleProvider),
                description: ref.watch(descriptionProvider),
                category: ref.watch(complaintCategoryProvider),
                status: 'pending',
                hostel: ref.watch(hostelProvider),
                roomNo: ref.watch(roomNoProvider),
                isIndividual:
                    ref.watch(complaintTypeProvider) == 'Common' ? false : true,
                complaintType: ref.watch(complaintTypeProvider),
                date: DateTime.now(),
                imageLink: downloadURL,
              );
              print(complaint.toMap());
              await ref
                  .watch(complaintRepositoryProvider)
                  .registerComplaint(ref, complaint);

              await ref.watch(onPageChangeProvider).call(0);
              clearForm(ref);
            } catch (error) {
              displaySnackBar('Error', '$error');
            }

            ref.watch(isLoadingProvider.notifier).state = false;
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
