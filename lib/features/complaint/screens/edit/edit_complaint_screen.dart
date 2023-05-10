import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/dialog.dart';
import 'package:complaint_portal/common/widgets/dropdown_dialog.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/screens/edit/edit_image_block.dart';
import 'package:complaint_portal/features/complaint/screens/edit/submit_complaint_form.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../providers/edit_complaint_form_provider.dart';

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
  late final TextEditingController _roomNoController;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(hostelProvider.notifier).state = widget.complaint.hostel;
      ref.read(imageProvider.notifier).state = widget.complaint.imageLink;
    });

    _titleController = TextEditingController(text: widget.complaint.title);
    _descriptionController =
        TextEditingController(text: widget.complaint.description);
    _roomNoController = TextEditingController(text: widget.complaint.roomNo);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _roomNoController.dispose();
    super.dispose();
  }



  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final isLoading = ref.watch(isLoadingProvider);
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
                title: Row(children: [
              const Text('Edit Complaint'),
              const Spacer(),
              if (!isLoading)
                IconButton(
                  icon: const Icon(FeatherIcons.trash2, color: Colors.black),
                  onPressed: () async {
                    final result = await dialogResult('Delete Complaint',
                        'Are you sure you want to delete this complaint?');
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
              if (!isLoading)
                IconButton(
                  icon: const Icon(
                    FeatherIcons.save,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final result = await dialogResult('Save Changes',
                          'Are you sure you want to save the changes?');
                      if (result == true) {
                        editComplaint(
                          ref,
                          user,
                          _titleController.text,
                          _descriptionController.text,
                          ref.read(hostelProvider),
                          widget.complaint.complaintType,
                          _roomNoController.text,
                          ref.read(imageProvider),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormFieldItem(
                        initValue: widget.complaint.cid,
                        enabled: false,
                        labelText: 'ID',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.complaintType,
                        enabled: false,
                        labelText: 'Category',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        validator: (String? value) {
                          return isTitle(value);
                        },
                        controller: _titleController,
                        labelText: 'Title',
                        enabled: !isLoading,
                        allowDelete: !isLoading,
                        onDelete: () {
                          _titleController.clear();
                        },
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        controller: _descriptionController,
                        labelText: 'Description',
                        validator: (String? value) {
                          return isDescription(value);
                        },
                        maxLines: 4,
                        enabled: !isLoading,
                        allowDelete: !isLoading,
                        onDelete: () {
                          _descriptionController.clear();
                        },
                      ),
                      SizedBox(height: kFormSpacing),
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     debugPrint("Edit Complaint Page: Hostel Consumer");
                      //     final loading = ref.watch(isLoadingProvider);
                      //     return
                      TextFormFieldItem(
                        labelText: 'Hostel',
                        controller: TextEditingController(
                            text: ref.watch(hostelProvider) != null
                                ? ref.watch(hostelProvider).toString()
                                : 'Select Hostel'),
                        enabled: !isLoading,
                        suffixIcon: isLoading ? null : FeatherIcons.chevronDown,
                        canEdit: false,
                        onSuffixTap: () async {
                          // final selected = await showDropDownDialog(
                          //   title: 'Select Hostel',
                          //   items: Hostel.values
                          //       .map((e) => e.toString().split('.').last)
                          //       .toList(),
                          // );
                          // if (selected != null) {
                          //   ref.watch(hostelProvider.notifier).state =
                          //       Hostel.fromString(selected);
                          // }
                        },
                        //     );
                        //   },
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          _roomNoController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: _roomNoController.selection,
                          );
                        },
                        controller: _roomNoController,
                        labelText: 'Room No',
                        validator: (String? value) {
                          return isRoom(value);
                        },
                        enabled: !isLoading,
                        allowDelete: !isLoading,
                        onDelete: () {
                          _roomNoController.clear();
                        },
                      ),
                      SizedBox(height: kFormSpacing),
                      const EditImageBlock(),
                      SizedBox(height: kFormSpacing),
                    ],
                  ),
                ),
              ),
            )),
        Consumer(builder: (context, ref, child) {
          debugPrint("Edit Complaint Page: Loading Consumer");
          return ref.watch(isLoadingProvider)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox();
        }),
      ],
    );
  }
}



// editComplaint(
//   ref,
//   UserModel user,
//   String title,
//   String description,
//   Hostel? hostel,
//   String? complaintType,
//   String roomNo,
//   image,
//   GlobalKey<FormState> formKey,
//   Complaint complaint,
// ) async {
//   if (hostel == null) {
//     displaySnackBar("Form Error", 'Please select a Hostel');
//   }
//   if (complaintType == null) {
//     displaySnackBar("Form Error", 'Please select a Complaint Type');
//   }
//   if (!formKey.currentState!.validate()) {
//     displaySnackBar('Error', 'Please fill all the fields');
//     return;
//   }

//   if (!await checkConnectivity(ref)) return;

//   ref.read(isLoadingProvider.notifier).state = true;

//   if (image is File) {
//     image = await ref
//         .watch(firebaseStorageRepositoryProvider)
//         .getDownloadURL(ref, complaint.cid, image);
//   }

//   final Complaint updatedComplaint = complaint.copyWith(
//     title: title,
//     description: description,
//     hostel: hostel,
//     complaintType: complaintType,
//     roomNo: roomNo,
//     imageLink: image,
//   );

//   final repository = ref.watch(complaintRepositoryProvider);
//   final updated = await repository.updateComplaint(ref, updatedComplaint);
//   Get.back();
//   ref.read(isLoadingProvider.notifier).state = false;
//   if (updated) {
//     displaySnackBar('Success', 'Complaint Edited');
//     debugPrint('Complaint Edited');
//   } else {
//     displaySnackBar('Error', 'Something went wrong');
//     debugPrint('Something went wrong');
//   }
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_portal/common/services/network/connectivity_service.dart';
// import 'package:complaint_portal/common/services/image_picker.dart';
// import 'package:complaint_portal/common/utils/constants.dart';
// import 'package:complaint_portal/common/utils/validators.dart';
// import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
// import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
// import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
// import 'package:complaint_portal/models/complaint_model.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../widgets/dialog.dart';

// final isLoadingProvider = StateProvider<bool>((ref) => false);

// // final editStateProvider = StateProvider<Map<String, dynamic>>(
// //   (ref) => {
// //     "hostel": "",
// //     "image": "",
// //   },
// // );
// final imageProvider = StateProvider<dynamic>((ref) => null);
// final hostelProvider = StateProvider<String?>((ref) => "");

// class EditComplaintPage extends ConsumerStatefulWidget {
//   final Complaint complaint;
//   const EditComplaintPage({
//     super.key,
//     required this.complaint,
//   });

//   @override
//   ConsumerState<EditComplaintPage> createState() => _EditComplaintPageState();
// }

// class _EditComplaintPageState extends ConsumerState<EditComplaintPage> {
//   late final TextEditingController _titleController;
//   late final TextEditingController _descriptionController;
//   late final TextEditingController _roomNoController;
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       // ref.read(editStateProvider.notifier).state = {
//       //   "hostel": widget.complaint.hostel,
//       //   "image": widget.complaint.imageLink,
//       // };
//       ref.read(hostelProvider.notifier).state = widget.complaint.hostel;
//       ref.read(imageProvider.notifier).state = widget.complaint.imageLink;
//     });

//     _titleController = TextEditingController(text: widget.complaint.title);
//     _descriptionController =
//         TextEditingController(text: widget.complaint.description);
//     _roomNoController = TextEditingController(text: widget.complaint.roomNo);
//     // hostel = widget.complaint.hostel;
//   }

//   final _formKey = GlobalKey<FormState>();
//   // var hostel;
//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(userProvider);
//     return Scaffold(
//         appBar: AppBar(
//             title: Row(children: [
//           const Text('Edit Complaint'),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(
//               FeatherIcons.trash2,
//               color: Colors.black,
//             ),
//             onPressed: () async {
//               final result = await dialogResult('Delete Complaint',
//                   'Are you sure you want to delete this complaint?');
//               if (result == true) {
//                 await ref
//                     .watch(complaintRepositoryProvider)
//                     .deleteComplaint(widget.complaint.cid!, ref);
//                 Get.back();
//                 Get.back();
//               }
//             },
//           ),
//           const SizedBox(width: 5),
//           IconButton(
//             icon: const Icon(
//               FeatherIcons.save,
//               color: Colors.black,
//             ),
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 final result = await dialogResult('Save Changes',
//                     'Are you sure you want to save the changes?');
//                 if (result == true) {
//                   editComplaint(
//                     ref,
//                     user,
//                     _titleController.text,
//                     _descriptionController.text,
//                     // ref.read(editStateProvider)["hostel"],
//                     ref.read(hostelProvider),
//                     // hostel,
//                     widget.complaint.complaintType,
//                     _roomNoController.text,
//                     ref.read(imageProvider),
//                     // ref.read(editStateProvider)["image"],
//                     _formKey,
//                     widget.complaint,
//                   );
//                 }
//               }
//             },
//           ),
//         ])),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormFieldItem(
//                     initValue: widget.complaint.cid,
//                     canEdit: false,
//                     labelText: 'ID',
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     initValue: widget.complaint.complaintType,
//                     canEdit: false,
//                     labelText: 'Category',
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     controller: _titleController,
//                     labelText: 'Title',
//                     validator: (String? value) {
//                       return isTitle(value);
//                     },
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     controller: _descriptionController,
//                     labelText: 'Description',
//                     validator: (String? value) {
//                       return isDescription(value);
//                     },
//                     maxLines: 4,
//                   ),
//                   SizedBox(height: kFormSpacing * 0.6),
//                   customDropDownMenu(
//                     context: context,
//                     headerText: "Hostel:",
//                     items: hostels,
//                     hintText: "Select Hostel",
//                     // value: ref.watch(editStateProvider)["hostel"],
//                     value: ref.watch(hostelProvider),
//                     // onChanged: (value) =>
//                     //     ref.watch(editStateProvider.notifier).update((state) {
//                     //   state["hostel"] = value;
//                     //   return state;
//                     // }),
//                     onChanged: (value) => ref
//                         .watch(hostelProvider.notifier)
//                         .update((state) => value),
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     textCapitalization: TextCapitalization.sentences,
//                     onChanged: (value) {
//                       _roomNoController.value = TextEditingValue(
//                           text: value.toUpperCase(),
//                           selection: _roomNoController.selection);
//                     },
//                     controller: _roomNoController,
//                     labelText: 'Room No',
//                     validator: (String? value) {
//                       return isRoom(value);
//                     },
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   // customDropDownMenu(
//                   //   headerText: "Complaint Type:",
//                   //   context: context,
//                   //   hintText: 'Complaint Type',
//                   //   value: complaintType,
//                   //   items: ['Individual', 'Common'],
//                   //   onChanged: (value) => setState(() => complaintType = value),
//                   // ),
//                   // SizedBox(height: kFormSpacing),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       border: Border.all(color: Colors.black.withOpacity(0.3)),
//                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                   ref.watch(editStateProvider)['image'] == null
//                                       ? 'Upload an Image'
//                                       : "Uploaded Image",
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF181D3D))),
//                             ),
//                             const Spacer(),
//                             ref.watch(editStateProvider)['image'] == null
//                                 ? IconButton(
//                                     // icon: const Icon(Icons.ref.watch(editStateProvider)['image']),
//                                     icon: const Icon(Icons.image),
//                                     onPressed: () async {
//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "image": await pickImage(
//                                             ImageSource.gallery),
//                                       };
//                                     },
//                                   )
//                                 : IconButton(
//                                     icon: const Icon(Icons.edit),
//                                     onPressed: () async {
//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "image": await pickImage(
//                                             ImageSource.gallery),
//                                       };
//                                     },
//                                   ),
//                             ref.watch(editStateProvider)['image'] == null
//                                 ? IconButton(
//                                     icon: const Icon(Icons.camera_alt),
//                                     onPressed: () async {
//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "image":
//                                             await pickImage(ImageSource.camera),
//                                       };
//                                     },
//                                   )
//                                 : IconButton(
//                                     icon: const Icon(Icons.delete),
//                                     onPressed: () async {
//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "image": null,
//                                       };
//                                     },
//                                   ),
//                           ],
//                         ),
//                         if (ref.watch(editStateProvider)['image'] is File &&
//                             ref.watch(editStateProvider)['image'] != null)
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Image.file(
//                               ref.watch(editStateProvider)['image'] as File,
//                               height: 200,
//                               width: 200,
//                             ),
//                           ),
//                         if (ref.watch(editStateProvider)['image'] is String &&
//                             ref.watch(editStateProvider)['image'] != null)
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Image.network(
//                               ref.watch(editStateProvider)['image'] as String,
//                               height: 200,
//                               width: 200,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: kFormSpacing),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }

// editComplaint(
//   ref,
//   UserModel user,
//   String title,
//   String description,
//   String? hostel,
//   String? complaintType,
//   String roomNo,
//   image,
//   GlobalKey<FormState> formKey,
//   Complaint complaint,
// ) async {
//   if (hostel == null) {
//     displaySnackBar("Form Error", 'Please select a Hostel');
//   }
//   if (complaintType == null) {
//     displaySnackBar("Form Error", 'Please select a Complaint Type');
//   }
//   if (!formKey.currentState!.validate()) {
//     displaySnackBar('Error', 'Please fill all the fields');
//     return;
//   }

//   if (!await checkConnectivity(ref)) return;

//   ref.read(isLoadingProvider.notifier).state = true;

//   if (image is File) {
//     image = await ref
//         .watch(firebaseStorageRepositoryProvider)
//         .getDownloadURL(ref, complaint.cid, image);
//   }
//   // Complaint newComplaint = complaint.copyWith(
//   //   title: title,
//   //   description: description,
//   //   hostel: hostel,
//   //   complaintType: complaintType,
//   //   roomNo: roomNo,
//   //   imageLink: image,
//   // );
//   // print(newComplaint.toMap());
//   // await ref.watch(complaintRepositoryProvider).updateComplaint(ref, complaint);

//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final DocumentReference documentReference =
//       firestore.collection('complaints').doc(complaint.cid);
//   await documentReference.update({
//     'title': title,
//     'description': description,
//     'hostel': hostel,
//     'complaintType': complaintType,
//     'roomNo': roomNo,
//     'updated at': DateTime.now(),
//     if (image != null) 'imageLink': image,
//   }).whenComplete(() {
//     Get.back();
//     displaySnackBar('Success', 'Complaint Edited');
//   }).catchError((e) => displaySnackBar(
//         'Error',
//         e.toString(),
//       ));
//   ref.read(isLoadingProvider.notifier).state = false;
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_portal/common/services/network/connectivity_service.dart';
// import 'package:complaint_portal/common/services/image_picker.dart';
// import 'package:complaint_portal/common/utils/constants.dart';
// import 'package:complaint_portal/common/utils/validators.dart';
// import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
// import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
// import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
// import 'package:complaint_portal/models/complaint_model.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../widgets/dialog.dart';

// final isLoadingProvider = StateProvider<bool>((ref) => false);

// final editStateProvider = StateProvider<Map<String, dynamic>>(
//   (ref) => {
//     "hostel": "",
//     "imageLink": "",
//   },
// );

// class EditComplaintPage extends ConsumerStatefulWidget {
//   final Complaint complaint;
//   const EditComplaintPage({
//     super.key,
//     required this.complaint,
//   });

//   @override
//   ConsumerState<EditComplaintPage> createState() => _EditComplaintPageState();
// }

// class _EditComplaintPageState extends ConsumerState<EditComplaintPage> {
//   late final TextEditingController _titleController;
//   late final TextEditingController _descriptionController;
//   // late final TextEditingController _categoryController;
//   late final TextEditingController _roomNoController;
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.read(editStateProvider.notifier).state = {
//         "hostel": widget.complaint.hostel,
//         "imageLink": widget.complaint.imageLink,
//       };
//     });

//     _titleController = TextEditingController(text: widget.complaint.title);
//     _descriptionController =
//         TextEditingController(text: widget.complaint.description);
//     _roomNoController = TextEditingController(text: widget.complaint.roomNo);
//     // hostel = widget.complaint.hostel;
//     complaintType = widget.complaint.complaintType;
//     // image = widget.complaint.imageLink;
//   }

//   // String? hostel;
//   String? complaintType;
//   // dynamic image;
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(userProvider);
//     return Scaffold(
//         appBar: AppBar(
//             title: Row(children: [
//           const Text('Edit Complaint'),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(
//               FeatherIcons.trash2,
//               color: Colors.black,
//             ),
//             onPressed: () async {
//               final result = await dialogResult('Delete Complaint',
//                   'Are you sure you want to delete this complaint?');
//               if (result == true) {
//                 await ref
//                     .watch(complaintRepositoryProvider)
//                     .deleteComplaint(widget.complaint.cid!, ref);
//                 Get.back();
//                 Get.back();
//               }
//             },
//           ),
//           const SizedBox(width: 5),
//           IconButton(
//             icon: const Icon(
//               FeatherIcons.save,
//               color: Colors.black,
//             ),
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 final result = await dialogResult('Save Changes',
//                     'Are you sure you want to save the changes?');
//                 if (result == true) {
//                   editComplaint(
//                     ref,
//                     user,
//                     _titleController.text,
//                     _descriptionController.text,
//                     // hostel,
//                     ref.read(editStateProvider)["hostel"],
//                     complaintType,
//                     _roomNoController.text,
//                     // image,
//                     ref.read(editStateProvider)["imageLink"],
//                     _formKey,
//                     widget.complaint,
//                   );
//                 }
//               }
//             },
//           ),
//         ])),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormFieldItem(
//                     initValue: widget.complaint.cid,
//                     canEdit: false,
//                     labelText: 'ID',
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     // controller: _categoryController,
//                     canEdit: false,
//                     labelText: 'Category',
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     controller: _titleController,
//                     labelText: 'Title',
//                     validator: (String? value) {
//                       return isTitle(value);
//                     },
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     controller: _descriptionController,
//                     labelText: 'Description',
//                     validator: (String? value) {
//                       return isDescription(value);
//                     },
//                     maxLines: 4,
//                   ),
//                   SizedBox(height: kFormSpacing * 0.6),
//                   customDropDownMenu(
//                       context: context,
//                       headerText: "Hostel:",
//                       items: hostels,
//                       hintText: "Select Hostel",
//                       // value: hostel,
//                       value: ref.read(editStateProvider)["hostel"],
//                       onChanged: (value) {
//                         ref.read(editStateProvider.notifier).state = {
//                           "hostel": value,
//                           "imageLink": ref.read(editStateProvider)["imageLink"],
//                         };
//                       }),
//                   SizedBox(height: kFormSpacing),
//                   TextFormFieldItem(
//                     textCapitalization: TextCapitalization.sentences,
//                     onChanged: (value) {
//                       _roomNoController.value = TextEditingValue(
//                           text: value.toUpperCase(),
//                           selection: _roomNoController.selection);
//                     },
//                     controller: _roomNoController,
//                     labelText: 'Room No',
//                     validator: (String? value) {
//                       return isRoom(value);
//                     },
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   customDropDownMenu(
//                     headerText: "Complaint Type:",
//                     context: context,
//                     hintText: 'Complaint Type',
//                     value: complaintType,
//                     items: ['Individual', 'Common'],
//                     onChanged: (value) => setState(() => complaintType = value),
//                   ),
//                   SizedBox(height: kFormSpacing),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       border: Border.all(color: Colors.black.withOpacity(0.3)),
//                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Text(
//                                   ref.watch(editStateProvider)['imageLink'] ==
//                                           null
//                                       ? 'Upload an Image'
//                                       : "Uploaded Image",
//                                   style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF181D3D))),
//                             ),
//                             const Spacer(),
//                             ref.watch(editStateProvider)['imageLink'] == null
//                                 ? IconButton(
//                                     // icon: const Icon(Icons.ref.watch(editStateProvider)['imageLink']),
//                                     icon: const Icon(Icons.image),
//                                     onPressed: () async {
//                                       // ref.watch(
//                                       //         editStateProvider)['imageLink'] =
//                                       //     await pickImage(ImageSource.gallery);
//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "imageLink": await pickImage(
//                                             ImageSource.gallery),

//                                         // setState(() {});
//                                       };
//                                     },
//                                   )
//                                 : IconButton(
//                                     icon: const Icon(Icons.edit),
//                                     onPressed: () async {
//                                       // ref.watch(editStateProvider)['imageLink'] = null;
//                                       // pickedImage =
//                                       // ref.watch(
//                                       //         editStateProvider)['imageLink'] =
//                                       //     await pickImage(ImageSource.gallery);

//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "imageLink": await pickImage(
//                                             ImageSource.gallery),
//                                       };

//                                       // setState(() {});
//                                     },
//                                   ),
//                             ref.watch(editStateProvider)['imageLink'] == null
//                                 ? IconButton(
//                                     icon: const Icon(Icons.camera_alt),
//                                     onPressed: () async {
//                                       // pickedImage =
//                                       // ref.watch(
//                                       // editStateProvider)['imageLink'] =
//                                       // await pickImage(ImageSource.camera);

//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "imageLink":
//                                             await pickImage(ImageSource.camera),
//                                       };

//                                       // ref.watch(
//                                       //         editStateProvider)['imageLink'] =
//                                       //     await pickImage(ImageSource.camera);
//                                       // setState(() {});
//                                     },
//                                   )
//                                 : IconButton(
//                                     icon: const Icon(Icons.delete),
//                                     onPressed: () {
//                                       // ref.watch(
//                                       //         editStateProvider)['imageLink'] =
//                                       //     null;

//                                       ref
//                                           .watch(editStateProvider.notifier)
//                                           .state = {
//                                         "hostel": ref.read(
//                                                 editStateProvider)['hostel']
//                                             as String?,
//                                         "imageLink": null,
//                                       };

//                                       // ref.watch(
//                                       //         editStateProvider)['imageLink'] =
//                                       //     null;
//                                       // pickedImage = null;
//                                       // setState(() {});
//                                     },
//                                   ),
//                           ],
//                         ),
//                         if (ref.watch(editStateProvider)['imageLink'] is File &&
//                             ref.watch(editStateProvider)['imageLink'] != null)
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Image.file(
//                               ref.watch(editStateProvider)['imageLink'] as File,
//                               height: 200,
//                               width: 200,
//                             ),
//                           ),
//                         if (ref.watch(editStateProvider)['imageLink']
//                                 is String &&
//                             ref.watch(editStateProvider)['imageLink'] != null)
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Image.network(
//                               ref.watch(editStateProvider)['imageLink']
//                                   as String,
//                               height: 200,
//                               width: 200,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: kFormSpacing),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }

// editComplaint(
//   ref,
//   UserModel user,
//   String title,
//   String description,
//   String? hostel,
//   String? complaintType,
//   String roomNo,
//   image,
//   GlobalKey<FormState> formKey,
//   Complaint complaint,
// ) async {
//   if (hostel == null) {
//     displaySnackBar("Form Error", 'Please select a Hostel');
//   }
//   if (complaintType == null) {
//     displaySnackBar("Form Error", 'Please select a Complaint Type');
//   }
//   if (!formKey.currentState!.validate()) {
//     displaySnackBar('Error', 'Please fill all the fields');
//     return;
//   }

//   if (!await checkConnectivity(ref)) return;

//   ref.read(isLoadingProvider.notifier).state = true;

//   if (image is File) {
//     image = await ref
//         .watch(firebaseStorageRepositoryProvider)
//         .getDownloadURL(ref, complaint.cid, image);
//   }
//   // Complaint newComplaint = complaint.copyWith(
//   //   title: title,
//   //   description: description,
//   //   hostel: hostel,
//   //   complaintType: complaintType,
//   //   roomNo: roomNo,
//   //   imageLink: image,
//   // );
//   // print(newComplaint.toMap());
//   // await ref.watch(complaintRepositoryProvider).updateComplaint(ref, complaint);

//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final DocumentReference documentReference =
//       firestore.collection('complaints').doc(complaint.cid);
//   await documentReference.update({
//     'title': title,
//     'description': description,
//     'hostel': hostel,
//     'complaintType': complaintType,
//     'roomNo': roomNo,
//     'updated at': DateTime.now(),
//     if (image != null) 'imageLink': image,
//   }).whenComplete(() {
//     Get.back();
//     displaySnackBar('Success', 'Complaint Edited');
//   }).catchError((e) => displaySnackBar(
//         'Error',
//         e.toString(),
//       ));
//   ref.read(isLoadingProvider.notifier).state = false;
// }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_portal/common/services/network/connectivity_service.dart';
// import 'package:complaint_portal/common/services/image_picker.dart';
// import 'package:complaint_portal/common/utils/constants.dart';
// import 'package:complaint_portal/common/utils/enums.dart';
// import 'package:complaint_portal/common/utils/validators.dart';
// import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
// import 'package:complaint_portal/common/widgets/dialog.dart';
// import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
// import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
// import 'package:complaint_portal/features/complaint/screens/edit/edit_image_block.dart';
// import 'package:complaint_portal/models/complaint_model.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../providers/edit_complaint_form_provider.dart';
// import '../../widgets/dialog.dart';

// class EditComplaintPage extends ConsumerStatefulWidget {
//   final Complaint complaint;
//   const EditComplaintPage({
//     super.key,
//     required this.complaint,
//   });

//   @override
//   ConsumerState<EditComplaintPage> createState() => _EditComplaintPageState();
// }

// class _EditComplaintPageState extends ConsumerState<EditComplaintPage> {
//   late final TextEditingController _titleController;
//   late final TextEditingController _descriptionController;
//   late final TextEditingController _roomNoController;
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.read(hostelProvider.notifier).state = widget.complaint.hostel;
//       ref.read(imageProvider.notifier).state = widget.complaint.imageLink;
//     });

//     _titleController = TextEditingController(text: widget.complaint.title);
//     _descriptionController =
//         TextEditingController(text: widget.complaint.description);
//     _roomNoController = TextEditingController(text: widget.complaint.roomNo);
//     hostel = widget.complaint.hostel;
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _roomNoController.dispose();
//     super.dispose();
//   }

//   final _formKey = GlobalKey<FormState>();
//   Hostel? hostel;
//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(userProvider);
//     final isLoading = ref.watch(isLoadingProvider);
//     return Stack(
//       children: [
//         Scaffold(
//             appBar: AppBar(
//                 title: Row(children: [
//               const Text('Edit Complaint'),
//               const Spacer(),
//               if (!ref.watch(isLoadingProvider))
//                 IconButton(
//                   icon: const Icon(FeatherIcons.trash2, color: Colors.black),
//                   onPressed: () async {
//                     final result = await dialogResult('Delete Complaint',
//                         'Are you sure you want to delete this complaint?');
//                     if (result == true) {
//                       await ref
//                           .watch(complaintRepositoryProvider)
//                           .deleteComplaint(widget.complaint.cid!, ref);
//                       Get.back();
//                       Get.back();
//                     }
//                   },
//                 ),
//               const SizedBox(width: 5),
//               if (!ref.watch(isLoadingProvider))
//                 IconButton(
//                   icon: const Icon(
//                     FeatherIcons.save,
//                     color: Colors.black,
//                   ),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       final result = await dialogResult('Save Changes',
//                           'Are you sure you want to save the changes?');
//                       if (result == true) {
//                         editComplaint(
//                           ref,
//                           user,
//                           _titleController.text,
//                           _descriptionController.text,
//                           ref.read(hostelProvider),
//                           widget.complaint.complaintType,
//                           _roomNoController.text,
//                           ref.read(imageProvider),
//                           _formKey,
//                           widget.complaint,
//                         );
//                       }
//                     }
//                   },
//                 ),
//             ])),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormFieldItem(
//                         initValue: widget.complaint.cid,
//                         canEdit: false,
//                         labelText: 'ID',
//                       ),
//                       SizedBox(height: kFormSpacing),
//                       TextFormFieldItem(
//                         initValue: widget.complaint.complaintType,
//                         canEdit: false,
//                         labelText: 'Category',
//                       ),
//                       SizedBox(height: kFormSpacing),
//                       TextFormFieldItem(
//                         controller: _titleController,
//                         labelText: 'Title',
//                         canEdit: !isLoading,
//                         validator: (String? value) {
//                           return isTitle(value);
//                         },
//                         allowDelete: true,
//                         onDelete: () {
//                           _titleController.clear();
//                         },
//                       ),
//                       SizedBox(height: kFormSpacing),
//                       TextFormFieldItem(
//                         controller: _descriptionController,
//                         labelText: 'Description',
//                         canEdit: !isLoading,
//                         validator: (String? value) {
//                           return isDescription(value);
//                         },
//                         maxLines: 4,
//                         allowDelete: true,
//                         onDelete: () {
//                           _descriptionController.clear();
//                         },
//                       ),
//                       SizedBox(height: kFormSpacing * 0.6),
//                       Consumer(builder: (context, ref, child) {
//                         debugPrint("Edit Complaint Page: Hostel Consumer");
//                         // final hostel = ref.watch(hostelProvider);
//                         final loading = ref.watch(isLoadingProvider);
//                         //   if (loading) {
//                         //     return TextFormFieldItem(
//                         //       initValue: ref.watch(hostelProvider).toString(),
//                         //       labelText: 'Hostel',
//                         //       canEdit: !isLoading,
//                         //     );
//                         //   } else {
//                         //     return customDropDownMenu(
//                         //       context: context,
//                         //       headerText: "Hostel:",
//                         //       items: Hostel.getHostels(),
//                         //       hintText: "Select Hostel",
//                         //       // hintText: ref.watch(hostelProvider)!,
//                         //       // value: ref.watch(hostelProvider),
//                         //       // value: hostel,
//                         //       value: hostel.toString(),
//                         //       onChanged: (value) {
//                         //         if (isLoading == false) {
//                         //           return ref
//                         //               .watch(hostelProvider.notifier)
//                         //               .update(
//                         //                   (state) => Hostel.fromString(value));
//                         //         }
//                         //         setState(() {
//                         //           hostel = Hostel.fromString(value);
//                         //         });
//                         //       },
//                         //     );
//                         //   }

//                         // SizedBox(height: kFormSpacing),
//                         return TextFormFieldItem(
//                           // initValue: ref.watch(hostelProvider).toString(),
//                           labelText: 'Hostel',
//                           // canEdit: !isLoading,
//                           controller:
//                               TextEditingController(text: hostel.toString()),
//                           canEdit: false,
//                           suffixIcon: FeatherIcons.chevronDown,
//                           onSuffixTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: const Text('Select Hostel'),
//                                   content: SizedBox(
//                                     height: 200,
//                                     child: ListView.builder(
//                                       itemCount: Hostel.getHostels().length,
//                                       itemBuilder: (context, index) {
//                                         return ListTile(
//                                           title:
//                                               Text(Hostel.getHostels()[index]),
//                                           onTap: () {
//                                             setState(() {
//                                               hostel = Hostel.fromString(
//                                                   Hostel.getHostels()[index]);
//                                             });
//                                             Navigator.pop(context);
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       }),
//                       SizedBox(height: kFormSpacing),
//                       TextFormFieldItem(
//                         textCapitalization: TextCapitalization.sentences,
//                         onChanged: (value) {
//                           _roomNoController.value = TextEditingValue(
//                             text: value.toUpperCase(),
//                             selection: _roomNoController.selection,
//                           );
//                         },
//                         controller: _roomNoController,
//                         labelText: 'Room No',
//                         canEdit: !isLoading,
//                         validator: (String? value) {
//                           return isRoom(value);
//                         },
//                         allowDelete: true,
//                         onDelete: () {
//                           _roomNoController.clear();
//                         },
//                       ),
//                       SizedBox(height: kFormSpacing),
//                       const EditImageBlock(),
//                       SizedBox(height: kFormSpacing),
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//         Consumer(builder: (context, ref, child) {
//           debugPrint("Edit Complaint Page: Loading Consumer");
//           return ref.watch(isLoadingProvider)
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : const SizedBox();
//         }),
//       ],
//     );
//   }
// }

// editComplaint(
//   ref,
//   UserModel user,
//   String title,
//   String description,
//   Hostel? hostel,
//   String? complaintType,
//   String roomNo,
//   image,
//   GlobalKey<FormState> formKey,
//   Complaint complaint,
// ) async {
//   if (hostel == null) {
//     displaySnackBar("Form Error", 'Please select a Hostel');
//   }
//   if (complaintType == null) {
//     displaySnackBar("Form Error", 'Please select a Complaint Type');
//   }
//   if (!formKey.currentState!.validate()) {
//     displaySnackBar('Error', 'Please fill all the fields');
//     return;
//   }

//   if (!await checkConnectivity(ref)) return;

//   ref.read(isLoadingProvider.notifier).state = true;

//   if (image is File) {
//     image = await ref
//         .watch(firebaseStorageRepositoryProvider)
//         .getDownloadURL(ref, complaint.cid, image);
//   }

//   final Complaint updatedComplaint = complaint.copyWith(
//     title: title,
//     description: description,
//     hostel: hostel,
//     complaintType: complaintType,
//     roomNo: roomNo,
//     imageLink: image,
//   );

//   final repository = ref.watch(complaintRepositoryProvider);
//   final updated = await repository.updateComplaint(ref, updatedComplaint);
//   Get.back();
//   ref.read(isLoadingProvider.notifier).state = false;
//   if (updated) {
//     displaySnackBar('Success', 'Complaint Edited');
//     debugPrint('Complaint Edited');
//   } else {
//     displaySnackBar('Error', 'Something went wrong');
//     debugPrint('Something went wrong');
//   }
// }
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:complaint_portal/common/services/network/connectivity_service.dart';
// // import 'package:complaint_portal/common/services/image_picker.dart';
// // import 'package:complaint_portal/common/utils/constants.dart';
// // import 'package:complaint_portal/common/utils/validators.dart';
// // import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
// // import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
// // import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// // import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// // import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
// // import 'package:complaint_portal/models/complaint_model.dart';
// // import 'package:complaint_portal/models/user_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';

// // import '../widgets/dialog.dart';

// // final isLoadingProvider = StateProvider<bool>((ref) => false);

// // // final editStateProvider = StateProvider<Map<String, dynamic>>(
// // //   (ref) => {
// // //     "hostel": "",
// // //     "image": "",
// // //   },
// // // );
// // final imageProvider = StateProvider<dynamic>((ref) => null);
// // final hostelProvider = StateProvider<String?>((ref) => "");

// // class EditComplaintPage extends ConsumerStatefulWidget {
// //   final Complaint complaint;
// //   const EditComplaintPage({
// //     super.key,
// //     required this.complaint,
// //   });

// //   @override
// //   ConsumerState<EditComplaintPage> createState() => _EditComplaintPageState();
// // }

// // class _EditComplaintPageState extends ConsumerState<EditComplaintPage> {
// //   late final TextEditingController _titleController;
// //   late final TextEditingController _descriptionController;
// //   late final TextEditingController _roomNoController;
// //   @override
// //   void initState() {
// //     super.initState();

// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //       // ref.read(editStateProvider.notifier).state = {
// //       //   "hostel": widget.complaint.hostel,
// //       //   "image": widget.complaint.imageLink,
// //       // };
// //       ref.read(hostelProvider.notifier).state = widget.complaint.hostel;
// //       ref.read(imageProvider.notifier).state = widget.complaint.imageLink;
// //     });

// //     _titleController = TextEditingController(text: widget.complaint.title);
// //     _descriptionController =
// //         TextEditingController(text: widget.complaint.description);
// //     _roomNoController = TextEditingController(text: widget.complaint.roomNo);
// //     // hostel = widget.complaint.hostel;
// //   }

// //   final _formKey = GlobalKey<FormState>();
// //   // var hostel;
// //   @override
// //   Widget build(BuildContext context) {
// //     final user = ref.watch(userProvider);
// //     return Scaffold(
// //         appBar: AppBar(
// //             title: Row(children: [
// //           const Text('Edit Complaint'),
// //           const Spacer(),
// //           IconButton(
// //             icon: const Icon(
// //               FeatherIcons.trash2,
// //               color: Colors.black,
// //             ),
// //             onPressed: () async {
// //               final result = await dialogResult('Delete Complaint',
// //                   'Are you sure you want to delete this complaint?');
// //               if (result == true) {
// //                 await ref
// //                     .watch(complaintRepositoryProvider)
// //                     .deleteComplaint(widget.complaint.cid!, ref);
// //                 Get.back();
// //                 Get.back();
// //               }
// //             },
// //           ),
// //           const SizedBox(width: 5),
// //           IconButton(
// //             icon: const Icon(
// //               FeatherIcons.save,
// //               color: Colors.black,
// //             ),
// //             onPressed: () async {
// //               if (_formKey.currentState!.validate()) {
// //                 final result = await dialogResult('Save Changes',
// //                     'Are you sure you want to save the changes?');
// //                 if (result == true) {
// //                   editComplaint(
// //                     ref,
// //                     user,
// //                     _titleController.text,
// //                     _descriptionController.text,
// //                     // ref.read(editStateProvider)["hostel"],
// //                     ref.read(hostelProvider),
// //                     // hostel,
// //                     widget.complaint.complaintType,
// //                     _roomNoController.text,
// //                     ref.read(imageProvider),
// //                     // ref.read(editStateProvider)["image"],
// //                     _formKey,
// //                     widget.complaint,
// //                   );
// //                 }
// //               }
// //             },
// //           ),
// //         ])),
// //         body: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
// //             child: Form(
// //               key: _formKey,
// //               child: Column(
// //                 children: [
// //                   TextFormFieldItem(
// //                     initValue: widget.complaint.cid,
// //                     canEdit: false,
// //                     labelText: 'ID',
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     initValue: widget.complaint.complaintType,
// //                     canEdit: false,
// //                     labelText: 'Category',
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     controller: _titleController,
// //                     labelText: 'Title',
// //                     validator: (String? value) {
// //                       return isTitle(value);
// //                     },
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     controller: _descriptionController,
// //                     labelText: 'Description',
// //                     validator: (String? value) {
// //                       return isDescription(value);
// //                     },
// //                     maxLines: 4,
// //                   ),
// //                   SizedBox(height: kFormSpacing * 0.6),
// //                   customDropDownMenu(
// //                     context: context,
// //                     headerText: "Hostel:",
// //                     items: hostels,
// //                     hintText: "Select Hostel",
// //                     // value: ref.watch(editStateProvider)["hostel"],
// //                     value: ref.watch(hostelProvider),
// //                     // onChanged: (value) =>
// //                     //     ref.watch(editStateProvider.notifier).update((state) {
// //                     //   state["hostel"] = value;
// //                     //   return state;
// //                     // }),
// //                     onChanged: (value) => ref
// //                         .watch(hostelProvider.notifier)
// //                         .update((state) => value),
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     textCapitalization: TextCapitalization.sentences,
// //                     onChanged: (value) {
// //                       _roomNoController.value = TextEditingValue(
// //                           text: value.toUpperCase(),
// //                           selection: _roomNoController.selection);
// //                     },
// //                     controller: _roomNoController,
// //                     labelText: 'Room No',
// //                     validator: (String? value) {
// //                       return isRoom(value);
// //                     },
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   // customDropDownMenu(
// //                   //   headerText: "Complaint Type:",
// //                   //   context: context,
// //                   //   hintText: 'Complaint Type',
// //                   //   value: complaintType,
// //                   //   items: ['Individual', 'Common'],
// //                   //   onChanged: (value) => setState(() => complaintType = value),
// //                   // ),
// //                   // SizedBox(height: kFormSpacing),
// //                   Container(
// //                     width: double.infinity,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.rectangle,
// //                       border: Border.all(color: Colors.black.withOpacity(0.3)),
// //                       borderRadius: const BorderRadius.all(Radius.circular(20)),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(10),
// //                               child: Text(
// //                                   ref.watch(editStateProvider)['image'] == null
// //                                       ? 'Upload an Image'
// //                                       : "Uploaded Image",
// //                                   style: const TextStyle(
// //                                       fontSize: 18,
// //                                       fontWeight: FontWeight.bold,
// //                                       color: Color(0xFF181D3D))),
// //                             ),
// //                             const Spacer(),
// //                             ref.watch(editStateProvider)['image'] == null
// //                                 ? IconButton(
// //                                     // icon: const Icon(Icons.ref.watch(editStateProvider)['image']),
// //                                     icon: const Icon(Icons.image),
// //                                     onPressed: () async {
// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "image": await pickImage(
// //                                             ImageSource.gallery),
// //                                       };
// //                                     },
// //                                   )
// //                                 : IconButton(
// //                                     icon: const Icon(Icons.edit),
// //                                     onPressed: () async {
// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "image": await pickImage(
// //                                             ImageSource.gallery),
// //                                       };
// //                                     },
// //                                   ),
// //                             ref.watch(editStateProvider)['image'] == null
// //                                 ? IconButton(
// //                                     icon: const Icon(Icons.camera_alt),
// //                                     onPressed: () async {
// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "image":
// //                                             await pickImage(ImageSource.camera),
// //                                       };
// //                                     },
// //                                   )
// //                                 : IconButton(
// //                                     icon: const Icon(Icons.delete),
// //                                     onPressed: () async {
// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "image": null,
// //                                       };
// //                                     },
// //                                   ),
// //                           ],
// //                         ),
// //                         if (ref.watch(editStateProvider)['image'] is File &&
// //                             ref.watch(editStateProvider)['image'] != null)
// //                           Padding(
// //                             padding: const EdgeInsets.all(10),
// //                             child: Image.file(
// //                               ref.watch(editStateProvider)['image'] as File,
// //                               height: 200,
// //                               width: 200,
// //                             ),
// //                           ),
// //                         if (ref.watch(editStateProvider)['image'] is String &&
// //                             ref.watch(editStateProvider)['image'] != null)
// //                           Padding(
// //                             padding: const EdgeInsets.all(10),
// //                             child: Image.network(
// //                               ref.watch(editStateProvider)['image'] as String,
// //                               height: 200,
// //                               width: 200,
// //                             ),
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ));
// //   }
// // }

// // editComplaint(
// //   ref,
// //   UserModel user,
// //   String title,
// //   String description,
// //   String? hostel,
// //   String? complaintType,
// //   String roomNo,
// //   image,
// //   GlobalKey<FormState> formKey,
// //   Complaint complaint,
// // ) async {
// //   if (hostel == null) {
// //     displaySnackBar("Form Error", 'Please select a Hostel');
// //   }
// //   if (complaintType == null) {
// //     displaySnackBar("Form Error", 'Please select a Complaint Type');
// //   }
// //   if (!formKey.currentState!.validate()) {
// //     displaySnackBar('Error', 'Please fill all the fields');
// //     return;
// //   }

// //   if (!await checkConnectivity(ref)) return;

// //   ref.read(isLoadingProvider.notifier).state = true;

// //   if (image is File) {
// //     image = await ref
// //         .watch(firebaseStorageRepositoryProvider)
// //         .getDownloadURL(ref, complaint.cid, image);
// //   }
// //   // Complaint newComplaint = complaint.copyWith(
// //   //   title: title,
// //   //   description: description,
// //   //   hostel: hostel,
// //   //   complaintType: complaintType,
// //   //   roomNo: roomNo,
// //   //   imageLink: image,
// //   // );
// //   // print(newComplaint.toMap());
// //   // await ref.watch(complaintRepositoryProvider).updateComplaint(ref, complaint);

// //   FirebaseFirestore firestore = FirebaseFirestore.instance;
// //   final DocumentReference documentReference =
// //       firestore.collection('complaints').doc(complaint.cid);
// //   await documentReference.update({
// //     'title': title,
// //     'description': description,
// //     'hostel': hostel,
// //     'complaintType': complaintType,
// //     'roomNo': roomNo,
// //     'updated at': DateTime.now(),
// //     if (image != null) 'imageLink': image,
// //   }).whenComplete(() {
// //     Get.back();
// //     displaySnackBar('Success', 'Complaint Edited');
// //   }).catchError((e) => displaySnackBar(
// //         'Error',
// //         e.toString(),
// //       ));
// //   ref.read(isLoadingProvider.notifier).state = false;
// // }
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:complaint_portal/common/services/network/connectivity_service.dart';
// // import 'package:complaint_portal/common/services/image_picker.dart';
// // import 'package:complaint_portal/common/utils/constants.dart';
// // import 'package:complaint_portal/common/utils/validators.dart';
// // import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
// // import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
// // import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// // import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// // import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
// // import 'package:complaint_portal/models/complaint_model.dart';
// // import 'package:complaint_portal/models/user_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';

// // import '../widgets/dialog.dart';

// // final isLoadingProvider = StateProvider<bool>((ref) => false);

// // final editStateProvider = StateProvider<Map<String, dynamic>>(
// //   (ref) => {
// //     "hostel": "",
// //     "imageLink": "",
// //   },
// // );

// // class EditComplaintPage extends ConsumerStatefulWidget {
// //   final Complaint complaint;
// //   const EditComplaintPage({
// //     super.key,
// //     required this.complaint,
// //   });

// //   @override
// //   ConsumerState<EditComplaintPage> createState() => _EditComplaintPageState();
// // }

// // class _EditComplaintPageState extends ConsumerState<EditComplaintPage> {
// //   late final TextEditingController _titleController;
// //   late final TextEditingController _descriptionController;
// //   // late final TextEditingController _categoryController;
// //   late final TextEditingController _roomNoController;
// //   @override
// //   void initState() {
// //     super.initState();

// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //       ref.read(editStateProvider.notifier).state = {
// //         "hostel": widget.complaint.hostel,
// //         "imageLink": widget.complaint.imageLink,
// //       };
// //     });

// //     _titleController = TextEditingController(text: widget.complaint.title);
// //     _descriptionController =
// //         TextEditingController(text: widget.complaint.description);
// //     _roomNoController = TextEditingController(text: widget.complaint.roomNo);
// //     // hostel = widget.complaint.hostel;
// //     complaintType = widget.complaint.complaintType;
// //     // image = widget.complaint.imageLink;
// //   }

// //   // String? hostel;
// //   String? complaintType;
// //   // dynamic image;
// //   final _formKey = GlobalKey<FormState>();
// //   @override
// //   Widget build(BuildContext context) {
// //     final user = ref.watch(userProvider);
// //     return Scaffold(
// //         appBar: AppBar(
// //             title: Row(children: [
// //           const Text('Edit Complaint'),
// //           const Spacer(),
// //           IconButton(
// //             icon: const Icon(
// //               FeatherIcons.trash2,
// //               color: Colors.black,
// //             ),
// //             onPressed: () async {
// //               final result = await dialogResult('Delete Complaint',
// //                   'Are you sure you want to delete this complaint?');
// //               if (result == true) {
// //                 await ref
// //                     .watch(complaintRepositoryProvider)
// //                     .deleteComplaint(widget.complaint.cid!, ref);
// //                 Get.back();
// //                 Get.back();
// //               }
// //             },
// //           ),
// //           const SizedBox(width: 5),
// //           IconButton(
// //             icon: const Icon(
// //               FeatherIcons.save,
// //               color: Colors.black,
// //             ),
// //             onPressed: () async {
// //               if (_formKey.currentState!.validate()) {
// //                 final result = await dialogResult('Save Changes',
// //                     'Are you sure you want to save the changes?');
// //                 if (result == true) {
// //                   editComplaint(
// //                     ref,
// //                     user,
// //                     _titleController.text,
// //                     _descriptionController.text,
// //                     // hostel,
// //                     ref.read(editStateProvider)["hostel"],
// //                     complaintType,
// //                     _roomNoController.text,
// //                     // image,
// //                     ref.read(editStateProvider)["imageLink"],
// //                     _formKey,
// //                     widget.complaint,
// //                   );
// //                 }
// //               }
// //             },
// //           ),
// //         ])),
// //         body: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
// //             child: Form(
// //               key: _formKey,
// //               child: Column(
// //                 children: [
// //                   TextFormFieldItem(
// //                     initValue: widget.complaint.cid,
// //                     canEdit: false,
// //                     labelText: 'ID',
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     // controller: _categoryController,
// //                     canEdit: false,
// //                     labelText: 'Category',
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     controller: _titleController,
// //                     labelText: 'Title',
// //                     validator: (String? value) {
// //                       return isTitle(value);
// //                     },
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     controller: _descriptionController,
// //                     labelText: 'Description',
// //                     validator: (String? value) {
// //                       return isDescription(value);
// //                     },
// //                     maxLines: 4,
// //                   ),
// //                   SizedBox(height: kFormSpacing * 0.6),
// //                   customDropDownMenu(
// //                       context: context,
// //                       headerText: "Hostel:",
// //                       items: hostels,
// //                       hintText: "Select Hostel",
// //                       // value: hostel,
// //                       value: ref.read(editStateProvider)["hostel"],
// //                       onChanged: (value) {
// //                         ref.read(editStateProvider.notifier).state = {
// //                           "hostel": value,
// //                           "imageLink": ref.read(editStateProvider)["imageLink"],
// //                         };
// //                       }),
// //                   SizedBox(height: kFormSpacing),
// //                   TextFormFieldItem(
// //                     textCapitalization: TextCapitalization.sentences,
// //                     onChanged: (value) {
// //                       _roomNoController.value = TextEditingValue(
// //                           text: value.toUpperCase(),
// //                           selection: _roomNoController.selection);
// //                     },
// //                     controller: _roomNoController,
// //                     labelText: 'Room No',
// //                     validator: (String? value) {
// //                       return isRoom(value);
// //                     },
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   customDropDownMenu(
// //                     headerText: "Complaint Type:",
// //                     context: context,
// //                     hintText: 'Complaint Type',
// //                     value: complaintType,
// //                     items: ['Individual', 'Common'],
// //                     onChanged: (value) => setState(() => complaintType = value),
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                   Container(
// //                     width: double.infinity,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.rectangle,
// //                       border: Border.all(color: Colors.black.withOpacity(0.3)),
// //                       borderRadius: const BorderRadius.all(Radius.circular(20)),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(10),
// //                               child: Text(
// //                                   ref.watch(editStateProvider)['imageLink'] ==
// //                                           null
// //                                       ? 'Upload an Image'
// //                                       : "Uploaded Image",
// //                                   style: const TextStyle(
// //                                       fontSize: 18,
// //                                       fontWeight: FontWeight.bold,
// //                                       color: Color(0xFF181D3D))),
// //                             ),
// //                             const Spacer(),
// //                             ref.watch(editStateProvider)['imageLink'] == null
// //                                 ? IconButton(
// //                                     // icon: const Icon(Icons.ref.watch(editStateProvider)['imageLink']),
// //                                     icon: const Icon(Icons.image),
// //                                     onPressed: () async {
// //                                       // ref.watch(
// //                                       //         editStateProvider)['imageLink'] =
// //                                       //     await pickImage(ImageSource.gallery);
// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "imageLink": await pickImage(
// //                                             ImageSource.gallery),

// //                                         // setState(() {});
// //                                       };
// //                                     },
// //                                   )
// //                                 : IconButton(
// //                                     icon: const Icon(Icons.edit),
// //                                     onPressed: () async {
// //                                       // ref.watch(editStateProvider)['imageLink'] = null;
// //                                       // pickedImage =
// //                                       // ref.watch(
// //                                       //         editStateProvider)['imageLink'] =
// //                                       //     await pickImage(ImageSource.gallery);

// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "imageLink": await pickImage(
// //                                             ImageSource.gallery),
// //                                       };

// //                                       // setState(() {});
// //                                     },
// //                                   ),
// //                             ref.watch(editStateProvider)['imageLink'] == null
// //                                 ? IconButton(
// //                                     icon: const Icon(Icons.camera_alt),
// //                                     onPressed: () async {
// //                                       // pickedImage =
// //                                       // ref.watch(
// //                                       // editStateProvider)['imageLink'] =
// //                                       // await pickImage(ImageSource.camera);

// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "imageLink":
// //                                             await pickImage(ImageSource.camera),
// //                                       };

// //                                       // ref.watch(
// //                                       //         editStateProvider)['imageLink'] =
// //                                       //     await pickImage(ImageSource.camera);
// //                                       // setState(() {});
// //                                     },
// //                                   )
// //                                 : IconButton(
// //                                     icon: const Icon(Icons.delete),
// //                                     onPressed: () {
// //                                       // ref.watch(
// //                                       //         editStateProvider)['imageLink'] =
// //                                       //     null;

// //                                       ref
// //                                           .watch(editStateProvider.notifier)
// //                                           .state = {
// //                                         "hostel": ref.read(
// //                                                 editStateProvider)['hostel']
// //                                             as String?,
// //                                         "imageLink": null,
// //                                       };

// //                                       // ref.watch(
// //                                       //         editStateProvider)['imageLink'] =
// //                                       //     null;
// //                                       // pickedImage = null;
// //                                       // setState(() {});
// //                                     },
// //                                   ),
// //                           ],
// //                         ),
// //                         if (ref.watch(editStateProvider)['imageLink'] is File &&
// //                             ref.watch(editStateProvider)['imageLink'] != null)
// //                           Padding(
// //                             padding: const EdgeInsets.all(10),
// //                             child: Image.file(
// //                               ref.watch(editStateProvider)['imageLink'] as File,
// //                               height: 200,
// //                               width: 200,
// //                             ),
// //                           ),
// //                         if (ref.watch(editStateProvider)['imageLink']
// //                                 is String &&
// //                             ref.watch(editStateProvider)['imageLink'] != null)
// //                           Padding(
// //                             padding: const EdgeInsets.all(10),
// //                             child: Image.network(
// //                               ref.watch(editStateProvider)['imageLink']
// //                                   as String,
// //                               height: 200,
// //                               width: 200,
// //                             ),
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: kFormSpacing),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ));
// //   }
// // }

// // editComplaint(
// //   ref,
// //   UserModel user,
// //   String title,
// //   String description,
// //   String? hostel,
// //   String? complaintType,
// //   String roomNo,
// //   image,
// //   GlobalKey<FormState> formKey,
// //   Complaint complaint,
// // ) async {
// //   if (hostel == null) {
// //     displaySnackBar("Form Error", 'Please select a Hostel');
// //   }
// //   if (complaintType == null) {
// //     displaySnackBar("Form Error", 'Please select a Complaint Type');
// //   }
// //   if (!formKey.currentState!.validate()) {
// //     displaySnackBar('Error', 'Please fill all the fields');
// //     return;
// //   }

// //   if (!await checkConnectivity(ref)) return;

// //   ref.read(isLoadingProvider.notifier).state = true;

// //   if (image is File) {
// //     image = await ref
// //         .watch(firebaseStorageRepositoryProvider)
// //         .getDownloadURL(ref, complaint.cid, image);
// //   }
// //   // Complaint newComplaint = complaint.copyWith(
// //   //   title: title,
// //   //   description: description,
// //   //   hostel: hostel,
// //   //   complaintType: complaintType,
// //   //   roomNo: roomNo,
// //   //   imageLink: image,
// //   // );
// //   // print(newComplaint.toMap());
// //   // await ref.watch(complaintRepositoryProvider).updateComplaint(ref, complaint);

// //   FirebaseFirestore firestore = FirebaseFirestore.instance;
// //   final DocumentReference documentReference =
// //       firestore.collection('complaints').doc(complaint.cid);
// //   await documentReference.update({
// //     'title': title,
// //     'description': description,
// //     'hostel': hostel,
// //     'complaintType': complaintType,
// //     'roomNo': roomNo,
// //     'updated at': DateTime.now(),
// //     if (image != null) 'imageLink': image,
// //   }).whenComplete(() {
// //     Get.back();
// //     displaySnackBar('Success', 'Complaint Edited');
// //   }).catchError((e) => displaySnackBar(
// //         'Error',
// //         e.toString(),
// //       ));
// //   ref.read(isLoadingProvider.notifier).state = false;
// // }
