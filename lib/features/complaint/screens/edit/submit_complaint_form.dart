import 'dart:io';

import 'package:complaint_portal/common/services/network/connectivity_service.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../providers/edit_complaint_form_provider.dart';

editComplaint(
  ref,
  UserModel user,
  String title,
  String description,
  Hostel? hostel,
  String? complaintType,
  String roomNo,
  image,
  GlobalKey<FormState> formKey,
  Complaint complaint,
) async {
  if (hostel == null) {
    displaySnackBar("Form Error", 'Please select a Hostel');
  }
  if (complaintType == null) {
    displaySnackBar("Form Error", 'Please select a Complaint Type');
  }
  if (!formKey.currentState!.validate()) {
    displaySnackBar('Error', 'Please fill all the fields');
    return;
  }

  if (!await checkConnectivity(ref)) return;

  ref.read(isLoadingProvider.notifier).state = true;

  if (image is File) {
    image = await ref
        .watch(firebaseStorageRepositoryProvider)
        .getDownloadURL(ref, complaint.cid, image);
  }

  final Complaint updatedComplaint = complaint.copyWith(
    title: title,
    description: description,
    hostel: hostel,
    complaintType: complaintType,
    roomNo: roomNo,
    imageLink: image,
  );

  final repository = ref.watch(complaintRepositoryProvider);
  final updated = await repository.updateComplaint(ref, updatedComplaint);
  Get.back();
  ref.read(isLoadingProvider.notifier).state = false;
  if (updated) {
    displaySnackBar('Success', 'Complaint Edited');
    debugPrint('Complaint Edited');
  } else {
    displaySnackBar('Error', 'Something went wrong');
    debugPrint('Something went wrong');
  }
}
