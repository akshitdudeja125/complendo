// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/utils/constants.dart';
import 'package:complaint_portal/widgets/custom_drop_down_menu.dart';
import 'package:complaint_portal/widgets/text_form_field_item.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/complaint_model.dart';
import '../utils/validators.dart';

class ComposeComplaint extends StatelessWidget {
  static const pageName = "Register Complaint";
  static const route = "/register-complaint";
  const ComposeComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ComplaintForm(),
              ),
            ),
          ),
        ],
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
  var complaintCategory;
  late final User user;
  File? pickedImage;
  bool isLoading = false;

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
    user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      nameController.text = value['name'];
      emailController.text = value['email'];
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
        'Please select a complaint category',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        Get.snackbar(
          'Error',
          'No Internet Connection',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        return;
      }

      Get.snackbar(
        'Processing Data',
        'Please wait',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      setState(() {
        isLoading = true;
      });
      final complaintId =
          FirebaseFirestore.instance.collection('complaints').doc().id;
      String? downloadURL;
      try {
        if (pickedImage != null) {
          // app check
          final Reference storageReference = FirebaseStorage.instance
              .ref()
              .child('complaints/complaint_$complaintId');
          // app check
          // final String? appCheckToken =
          // await FirebaseAppCheck.instance.getToken();
          // final String token = appCheckToken ?? '';
          final UploadTask uploadTask = storageReference.putFile(
            pickedImage!,
            // SettableMetadata(
            //   customMetadata: {'Firebase-AppCheck': token},
            // ),
          );
          await uploadTask.whenComplete(() {
            print('File Uploaded');
          });
          downloadURL = await storageReference.getDownloadURL();
        }
        // get user fata from firestore
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final Complaint complaint = Complaint(
          uid: user.uid,
          cid: complaintId,
          title: titleController.text,
          description: descriptionController.text,
          category: complaintCategory,
          status: 'Pending',
          // isIndividual: complaintType == 'Common' ? false : true,
          complaintType: complaintType,
          date: DateTime.now(),
          imageLink: downloadURL,
        );
        print(complaint.toMap());
        await FirebaseFirestore.instance
            .collection('complaints')
            .doc(complaintId)
            .set(
              complaint.toMap(),
            )
            .onError(
              (error, stackTrace) => Get.snackbar(
                'Error',
                'Something went wrong',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black,
                colorText: Colors.white,
              ),
            );
      } catch (error) {
        debugPrint(error.toString());
        Get.snackbar(
          'Error',
          'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        setState(() {
          isLoading = false;
        });
        return;
      } finally {
        Get.snackbar(
          'Success',
          'Complaint registered successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
              SizedBox(height: kFormSpacing * 0.59),
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
                items: ['Individual', 'Common'],
                onChanged: (value) {
                  setState(() {
                    complaintType = value;
                  });
                },
              ),
              SizedBox(height: kFormSpacing),
              customDropDownMenu(
                headerText: "Complaint Category:",
                context: context,
                hintText: 'Complaint Category',
                value: complaintCategory,
                items: complaintCategories,
                onChanged: (value) {
                  setState(() {
                    complaintCategory = value;
                  });
                },
              ),
              SizedBox(height: kFormSpacing),
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
              SizedBox(height: kFormSpacing),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLoading ? Colors.grey : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                      )
                    : const Icon(Icons.send),
                label: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                // maje the row take only the space it needs

                onPressed: () {
                  isLoading ? null : _formSubmit();
                  // _formSubmit();
                },
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
