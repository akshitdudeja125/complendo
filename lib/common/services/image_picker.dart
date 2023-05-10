import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource imageType) async {
  try {
    final photo = await ImagePicker().pickImage(source: imageType);
    if (photo == null) return null;
    return File(photo.path);
  } catch (error) {
    return null;
  }
}
