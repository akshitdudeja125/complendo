// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/utils/constants.dart';
// import 'package:complaint_portal/utils/validators.dart';
import 'package:complaint_portal/widgets/clipper.dart';
import 'package:complaint_portal/widgets/custom_drop_down_menu.dart';
import 'package:complaint_portal/widgets/text_form_field_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/complaint_model.dart';
import '../providers/auth_provider.dart';
import '../providers/database_provider.dart';
import '../utils/validators.dart';

class ComposeComplaint extends StatefulWidget {
  const ComposeComplaint({super.key});

  @override
  State<ComposeComplaint> createState() => ComposeComplaintState();
}

class ComposeComplaintState extends State<ComposeComplaint> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    color: const Color(0xFF181D3D),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 16),
                        Text(
                          'Register Complaint',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.apply(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const ComplaintForm()
            ],
          ),
        ),
      ),
    );
  }
}

class ComplaintForm extends ConsumerStatefulWidget {
  const ComplaintForm({super.key});

  @override
  ConsumerState<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends ConsumerState<ComplaintForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final roomNoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var complaintType;
  var hostel;
  final user = FirebaseAuth.instance.currentUser;
  File? pickedImage;
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      nameController.text = value['name'];
      emailController.text = value['email'];
      roomNoController.text = value['roomNo'];
      hostel = value['hostel'];
    });
  }

  _formSubmit() async {
    if (hostel == null) {
      Get.snackbar(
        'Error',
        'Please select a hostel',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      return;
    }
    if (complaintType == null) {
      Get.snackbar(
        'Error',
        'Please select a complaint type',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      return;
    }
    if (pickedImage == null) {
      Get.snackbar(
        'Error',
        'Please upload an image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      Get.snackbar(
        'Processing Data',
        'Please wait',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      print('Form Validated');

      // Upload the image to firebase storage
      final reference = FirebaseStorage.instance
          .ref()
          .child("complaints")
          .child("complaint_${1}.png");
      UploadTask uploadTask =
          (await reference.putFile(pickedImage!)) as UploadTask;
      final downloadURL = await (await uploadTask).ref.getDownloadURL();
      final data = {
        'name': nameController.text,
        'email': emailController.text,
        'title': titleController.text,
        'description': descriptionController.text,
        'complaintType': complaintType,
        'status': 'Pending',
        'timestamp': DateTime.now(),
        'referencePic': downloadURL,
      };
      print(data);
      // ref.read(databaseProvider).addComplaint(
      //       user!.uid,
      //       titleController.text,
      //       descriptionController.text,
      //       complaintType,

      //     );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: formKey,
        child: Column(children: [
          TextFormFieldItem(
            controller: nameController,
            canEdit: false,
            labelText: 'Name',
          ),
          SizedBox(height: kFormSpacing),
          TextFormFieldItem(
            controller: emailController,
            labelText: 'Email',
            canEdit: false,
          ),
          SizedBox(height: kFormSpacing * 0.6),
          customDropDownMenu(
            context: context,
            headerText: "Hostel:",
            items: hostels,
            hintText: "Select Hostel",
            value: hostel,
            onChanged: (value) {
              setState(() {
                hostel = value;
              });
            },
          ),
          SizedBox(height: kFormSpacing),
          TextFormFieldItem(
            controller: roomNoController,
            labelText: 'Room No',
            validator: (String? value) {
              return isRoom(value);
            },
          ),
          SizedBox(height: kFormSpacing),
          customDropDownMenu(
            headerText: "Complaint Type:",
            context: context,
            hintText: 'Complaint Type',
            value: complaintType,
            items: complaintCategories,
            onChanged: (value) {
              setState(() {
                complaintType = value;
              });
            },
          ),
          SizedBox(height: kFormSpacing * 0.6),
          TextFormFieldItem(
            controller: titleController,
            labelText: 'Title',
            validator: (String? value) {
              return isTitle(value);
            },
          ),
          SizedBox(height: kFormSpacing),
          TextFormFieldItem(
            controller: descriptionController,
            labelText: 'Description',
            validator: (String? value) {
              return isDescription(value);
            },
            maxLines: 4,
          ),
          SizedBox(height: kFormSpacing),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          pickedImage == null
                              ? 'Upload an Image'
                              : "Uploaded Image",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181D3D))),
                    ),
                    const Spacer(),
                    pickedImage == null
                        ? IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {
                              pickImage(ImageSource.camera);
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                pickedImage = null;
                              });
                            },
                          ),
                    pickedImage == null
                        ? IconButton(
                            icon: const Icon(Icons.image),
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            },
                          ),
                  ],
                ),
                pickedImage == null
                    ? Container()
                    : Image.file(
                        pickedImage!,
                        height: 200,
                        width: 200,
                      ),
              ],
            ),
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.black,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //   ),
          //   child: const Text(
          //     'Upload Image',
          //     style: TextStyle(color: Colors.white, fontSize: 14),
          //   ),
          //   onPressed: () {
          //     _uploadImage();
          //   },
          // ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              _formSubmit();
            },
          ),
        ]),
      ),
    );
  }
}

// _uploadImage() async {
//   try {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     UploadTask? uploadTask;
//     Reference ref =
//         FirebaseStorage.instance.ref().child('complaints').child('/');
//     ref.putFile(File(pickedImage!.path));
//     await uploadTask!.whenComplete(() => null);
//     final imageUrl = await ref.getDownloadURL();
//     print(imageUrl);
//   } catch (e) {
//     print(e);
//   }
// }
