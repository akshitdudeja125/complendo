import 'dart:io';

import 'package:complaint_portal/providers/complaint_form_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageType, ref) async {
  try {
    final photo = await ImagePicker().pickImage(source: imageType);
    if (photo == null) return;
    ref.watch(pickedImageProvider.notifier).state = File(photo.path);
    // Get.back();
  } catch (error) {
    debugPrint(error.toString());
  }
}
