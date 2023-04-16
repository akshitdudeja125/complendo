import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/services/network/connectivity_service.dart';
import 'package:complaint_portal/common/services/image_picker.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/custom_app_bar.dart';
import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);

class EditComplaintPage extends ConsumerStatefulWidget {
  final Complaint complaint;
  const EditComplaintPage({
    super.key,
    required this.complaint,
  });

  @override
  ConsumerState<EditComplaintPage> createState() => _EditComplaintPageState();
}

class _EditComplaintPageState extends ConsumerState<EditComplaintPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _categoryController;
  late final TextEditingController _roomNoController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.complaint.title);
    _descriptionController =
        TextEditingController(text: widget.complaint.description);
    _categoryController =
        TextEditingController(text: widget.complaint.category);
    _roomNoController = TextEditingController(text: widget.complaint.roomNo);
    hostel = widget.complaint.hostel;
    complaintType = widget.complaint.complaintType;
    image = widget.complaint.imageLink;
  }

  deleteComplaintDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Complaint'),
        content: const Text('Are you sure you want to delete this complaint?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return result;
  }

  String? hostel;
  String? complaintType;
  dynamic image;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
        // appBar: CustomAppBar(
        // elevation: 0,
        // heading: 'Edit Complaint',
        // trailing: Flexible(
        //   child: Row(
        //     children: [
        //       IconButton(
        //         icon: const Icon(
        //           FeatherIcons.trash2,
        //           color: Colors.black,
        //         ),
        //         onPressed: () async {
        //           final result = await deleteComplaintDialog();
        //           if (result == true) {
        //             await ref
        //                 .watch(complaintRepositoryProvider)
        //                 .deleteComplaint(widget.complaint.cid!, ref);
        //             Get.back();
        //             Get.back();
        //           }
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        // ),
        appBar: AppBar(
            title: Row(children: [
          const Text('Edit Complaint'),
          const Spacer(),
          IconButton(
            icon: const Icon(
              FeatherIcons.trash2,
              color: Colors.black,
            ),
            onPressed: () async {
              final result = await deleteComplaintDialog();
              if (result == true) {
                await ref
                    .watch(complaintRepositoryProvider)
                    .deleteComplaint(widget.complaint.cid!, ref);
                Get.back();
                Get.back();
              }
            },
          ),
          const SizedBox(width: 5),
          //save BUTTON
          IconButton(
            icon: const Icon(
              FeatherIcons.save,
              color: Colors.black,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final result = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Save Changes'),
                    content: const Text(
                        'Are you sure you want to save the changes?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
                if (result == true) {
                  editComplaint(
                    ref,
                    user,
                    _titleController.text,
                    _descriptionController.text,
                    hostel,
                    complaintType,
                    _roomNoController.text,
                    image,
                    _formKey,
                    widget.complaint,
                  );
                }
              }
            },
          ),
        ])),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
            // padding: const EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    initValue: user.name,
                    canEdit: false,
                    labelText: 'Name',
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    initValue: user.email,
                    labelText: 'Email',
                    canEdit: false,
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    initValue: user.rollNo,
                    labelText: 'Roll Number',
                    canEdit: false,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    initValue: widget.complaint.cid,
                    canEdit: false,
                    labelText: 'ID',
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    controller: _categoryController,
                    canEdit: false,
                    labelText: 'Category',
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    controller: _titleController,
                    labelText: 'Title',
                    validator: (String? value) {
                      return isTitle(value);
                    },
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    controller: _descriptionController,
                    labelText: 'Description',
                    // onChanged: (value) {
                    //   ref.watch(descriptionProvider.notifier).state = value;
                    // },
                    validator: (String? value) {
                      return isDescription(value);
                    },
                    maxLines: 4,
                  ),
                  SizedBox(height: kFormSpacing * 0.6),
                  customDropDownMenu(
                      context: context,
                      headerText: "Hostel:",
                      items: hostels,
                      hintText: "Select Hostel",
                      value: hostel,
                      // value: widget.complaint.hostel,
                      onChanged: (value) {
                        setState(() {
                          hostel = value;
                          // _hostelController.text = value;
                        });
                      }),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) {
                      _roomNoController.value = TextEditingValue(
                          text: value.toUpperCase(),
                          selection: _roomNoController.selection);
                    },
                    controller: _roomNoController,
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
                    onChanged: (value) => setState(() => complaintType = value),
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
                                  image == null
                                      ? 'Upload an Image'
                                      : "Uploaded Image",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF181D3D))),
                            ),
                            const Spacer(),
                            image == null
                                ? IconButton(
                                    icon: const Icon(Icons.image),
                                    onPressed: () async {
                                      image =
                                          await pickImage(ImageSource.gallery);
                                      setState(() {});
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      // image = null;
                                      // pickedImage =
                                      image =
                                          await pickImage(ImageSource.gallery);
                                      setState(() {});
                                    },
                                  ),
                            image == null
                                ? IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    onPressed: () async {
                                      // pickedImage =
                                      image =
                                          await pickImage(ImageSource.camera);
                                      setState(() {});
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      image = null;
                                      // pickedImage = null;
                                      setState(() {});
                                    },
                                  ),
                          ],
                        ),
                        if (image is File && image != null)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.file(
                              image as File,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        if (image is String && image != null)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(
                              image as String,
                              height: 200,
                              width: 200,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: kFormSpacing),
                  // SubmitButton(
                  //   isLoadingProvider: isLoadingProvider,
                  //   onClick: () => editComplaint(
                  //     ref,
                  //     user,
                  //     _titleController.text,
                  //     _descriptionController.text,
                  //     hostel,
                  //     complaintType,
                  //     _roomNoController.text,
                  //     image,
                  //     _formKey,
                  //     widget.complaint,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}

editComplaint(
  ref,
  UserModel user,
  String title,
  String description,
  String? hostel,
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
  // Complaint newComplaint = complaint.copyWith(
  //   title: title,
  //   description: description,
  //   hostel: hostel,
  //   complaintType: complaintType,
  //   roomNo: roomNo,
  //   imageLink: image,
  // );
  // print(newComplaint.toMap());
  // await ref.watch(complaintRepositoryProvider).updateComplaint(ref, complaint);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentReference documentReference =
      firestore.collection('complaints').doc(complaint.cid);
  await documentReference.update({
    'title': title,
    'description': description,
    'hostel': hostel,
    'complaintType': complaintType,
    'roomNo': roomNo,
    'updated at': DateTime.now(),
    if (image != null) 'imageLink': image,
  }).whenComplete(() {
    // wait 1 second
    // Future.delayed(const Duration(microseconds: 50), () {
    // Get.back();
    // Get.back();
    displaySnackBar('Success', 'Complaint Edited');
    // });
  }).catchError((e) => displaySnackBar(
        'Error',
        e.toString(),
      ));
  ref.read(isLoadingProvider.notifier).state = false;
}
