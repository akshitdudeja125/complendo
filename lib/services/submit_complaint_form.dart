import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/providers/auth_provider.dart';
import 'package:complaint_portal/providers/complaint_form_provider.dart';
import 'package:complaint_portal/providers/page_controller_provider.dart';
import 'package:complaint_portal/services/connectivity_service.dart';
import 'package:complaint_portal/widgets/display_snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';

void formSubmit(ref) async {
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

  displaySnackBar('Details Verified', 'Processing Data');
  ref.watch(isLoadingProvider.notifier).state = true;

  final complaintId =
      FirebaseFirestore.instance.collection('complaints').doc().id;
  String? downloadURL;
  try {
    if (ref.watch(pickedImageProvider) != null) {
      // app check
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('complaints/complaint_$complaintId');
      // app check
      // final String? appCheckToken =
      // await FirebaseAppCheck.instance.getToken();
      // final String token = appCheckToken ?? '';
      final UploadTask uploadTask = storageReference.putFile(
        ref.watch(pickedImageProvider)!,
        // SettableMetadata(
        //   customMetadata: {'Firebase-AppCheck': token},
        // ),
      );
      await uploadTask.whenComplete(() {});
      downloadURL = await storageReference.getDownloadURL();
    }
    final Complaint complaint = Complaint(
      uid: ref.watch(currentUserProvider).value!.uid,
      // uid: ref.watch(authProvider).uid,
      cid: complaintId,
      title: ref.watch(titleProvider),
      description: ref.watch(descriptionProvider),
      category: ref.watch(complaintCategoryProvider),
      status: 'Pending',
      isIndividual: ref.watch(complaintTypeProvider) == 'Common' ? false : true,
      complaintType: ref.watch(complaintTypeProvider),
      date: DateTime.now(),
      imageLink: downloadURL,
    );
    await FirebaseFirestore.instance
        .collection('complaints')
        .doc(complaintId)
        .set(
          complaint.toMap(),
        )
        .onError((error, stackTrace) => displaySnackBar(
              'Error',
              'Something went wrong',
            ));
  } catch (error) {
    displaySnackBar('Error', 'Something went wrong');
    print(error);
    ref.watch(isLoadingProvider.notifier).state = false;
    return;
  } finally {
    displaySnackBar('Success', 'Complaint submitted successfully');
    ref.watch(isLoadingProvider.notifier).state = false;
    ref.watch(onPageChangeProvider).call(0);
    clearForm(ref);
  }
}
