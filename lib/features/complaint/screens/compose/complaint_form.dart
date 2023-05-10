import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_form_provider.dart';
import 'package:complaint_portal/features/complaint/screens/compose/sections/complaint_section.dart';
import 'package:complaint_portal/features/complaint/screens/compose/sections/user_data_section.dart';
import 'package:complaint_portal/features/complaint/widgets/submit_complaint_form.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/dropdown_dialog.dart';

class ComplaintForm extends ConsumerWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('ComplaintForm build');
    final isLoading = ref.watch(isLoadingProvider);
    return Stack(
      children: [
        if (isLoading) const Center(child: CircularProgressIndicator()),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Consumer(builder: (context, ref, _) {
                final UserModel user = ref.watch(userProvider);
                return Form(
                  key: ref.watch(formKeyProvider),
                  child: Column(
                    children: [
                      UserDataSection(user: user),
                      SizedBox(height: kFormSpacing),
                      const ComplaintSection(),
                      SizedBox(height: kFormSpacing),
                      SubmitButton(
                        isLoadingProvider: isLoadingProvider,
                        onClick: () {
                          submitComplaint(ref, user);
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
    // },
    // );
  }
}







// import 'package:complaint_portal/common/utils/enums.dart';
// import 'package:complaint_portal/common/utils/validators.dart';
// import 'package:complaint_portal/common/widgets/dropdown_dialog.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/complaint/providers/complaint_form_provider.dart';
// import 'package:complaint_portal/features/complaint/widgets/submit_complaint_form.dart';

// import 'package:complaint_portal/common/services/image_picker.dart';
// import 'package:complaint_portal/common/utils/constants.dart';
// import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
// import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
// import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// class ComplaintForm extends ConsumerStatefulWidget {
//   const ComplaintForm({super.key});

//   @override
//   ConsumerState<ComplaintForm> createState() => _ComplaintFormState();
// }

// class _ComplaintFormState extends ConsumerState<ComplaintForm> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.watch(hostelProvider.notifier).state =
//           ref.watch(userProvider).hostel!.value;
//       ref.watch(roomNoProvider.notifier).state = ref.watch(userProvider).roomNo;
//       roomNoController.text = ref.watch(userProvider).roomNo ?? '';
//     });
//   }

//   late final TextEditingController roomNoController = TextEditingController();
//   late final TextEditingController descriptionController =
//       TextEditingController();
//   late final TextEditingController titleController = TextEditingController();
//   @override
//   void dispose() {
//     roomNoController.dispose();
//     descriptionController.dispose();
//     titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final UserModel user = ref.watch(userProvider);
//     // final bool loading = ref.watch(isLoadingProvider);
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Form(
//             key: ref.watch(formKeyProvider),
//             child: Column(
//               children: [
//                 TextFormFieldItem(
//                   initValue: user.name,
//                   canEdit: false,
//                   labelText: 'Name',
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   initValue: user.email,
//                   labelText: 'Email',
//                   canEdit: false,
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   initValue: user.rollNo,
//                   labelText: 'Roll Number',
//                   canEdit: false,
//                   textCapitalization: TextCapitalization.characters,
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   labelText: 'Hostel',
//                   controller: TextEditingController(
//                       text: ref.watch(hostelProvider).toString()),
//                   suffixIcon: FeatherIcons.chevronDown,
//                   canEdit: false,
//                   onSuffixTap: () async {
//                     final selected = await showDropDownDialog(
//                       title: 'Select Hostel',
//                       items: Hostel.getHostels(),
//                     );
//                     if (selected != null) {
//                       ref.watch(hostelProvider.notifier).state = selected;
//                     }
//                   },
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   controller: roomNoController,
//                   onChanged: (value) {
//                     ref.watch(roomNoProvider.notifier).state = value;
//                   },
//                   labelText: 'Room No',
//                   validator: (String? value) {
//                     return isRoom(value);
//                   },
//                   allowDelete: true,
//                   onDelete: () {
//                     roomNoController.clear();
//                     ref.watch(roomNoProvider.notifier).state = null;
//                   },
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 // customDropDownMenu(
//                 //   headerText: "Complaint Type:",
//                 //   context: context,
//                 //   hintText: 'Complaint Type',
//                 //   value: ref.watch(complaintTypeProvider),
//                 //   items: ['Individual', 'Common'],
//                 //   onChanged: (value) =>
//                 //       ref.watch(complaintTypeProvider.notifier).state = value,
//                 // ),
//                 TextFormFieldItem(
//                   labelText: 'Complaint Category',
//                   controller: TextEditingController(
//                       text: ref.watch(complaintCategoryProvider) ?? 'Select'),
//                   suffixIcon: FeatherIcons.chevronDown,
//                   canEdit: false,
//                   onSuffixTap: () async {
//                     final selected = await showDropDownDialog(
//                       title: 'Select Complaint Category',
//                       items: complaintCategories,
//                     );
//                     if (selected != null) {
//                       ref.watch(complaintCategoryProvider.notifier).state =
//                           selected;
//                     }
//                   },
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   labelText: 'Complaint Type',
//                   controller: TextEditingController(
//                       text: ref.watch(complaintTypeProvider) ?? 'Select'),
//                   suffixIcon: FeatherIcons.chevronDown,
//                   canEdit: false,
//                   onSuffixTap: () async {
//                     final selected = await showDropDownDialog(
//                       title: 'Select Complaint Type',
//                       items: ['Individual', 'Common'],
//                     );
//                     if (selected != null) {
//                       ref.watch(complaintTypeProvider.notifier).state =
//                           selected;
//                     }
//                   },
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   onChanged: (value) {
//                     ref.watch(titleProvider.notifier).state = value;
//                   },
//                   controller: titleController,
//                   labelText: 'Title',
//                   validator: (String? value) {
//                     return isTitle(value);
//                   },
//                   allowDelete: true,
//                   onDelete: () {
//                     titleController.clear();
//                     ref.watch(titleProvider.notifier).state = null;
//                   },
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   labelText: 'Description',
//                   onChanged: (value) {
//                     ref.watch(descriptionProvider.notifier).state = value;
//                   },
//                   controller: descriptionController,
//                   validator: (String? value) {
//                     return isDescription(value);
//                   },
//                   allowDelete: true,
//                   onDelete: () {
//                     descriptionController.clear();
//                     ref.watch(descriptionProvider.notifier).state = null;
//                   },
//                   maxLines: 4,
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     border: Border.all(color: Colors.black.withOpacity(0.3)),
//                     borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Text(
//                                 ref.watch(pickedImageProvider) == null
//                                     ? 'Upload an Image'
//                                     : "Uploaded Image",
//                                 style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF181D3D))),
//                           ),
//                           const Spacer(),
//                           ref.watch(pickedImageProvider) == null
//                               ? IconButton(
//                                   icon: const Icon(Icons.image),
//                                   onPressed: () async {
//                                     ref
//                                             .watch(pickedImageProvider.notifier)
//                                             .state =
//                                         await pickImage(ImageSource.gallery);
//                                   },
//                                 )
//                               : IconButton(
//                                   icon: const Icon(Icons.edit),
//                                   onPressed: () async {
//                                     ref
//                                             .watch(pickedImageProvider.notifier)
//                                             .state =
//                                         await pickImage(ImageSource.gallery);
//                                   },
//                                 ),
//                           ref.watch(pickedImageProvider) == null
//                               ? IconButton(
//                                   icon: const Icon(Icons.camera_alt),
//                                   onPressed: () async {
//                                     ref
//                                             .watch(pickedImageProvider.notifier)
//                                             .state =
//                                         await pickImage(ImageSource.camera);
//                                   },
//                                 )
//                               : IconButton(
//                                   icon: const Icon(Icons.delete),
//                                   onPressed: () => ref
//                                       .watch(pickedImageProvider.notifier)
//                                       .state = null,
//                                 ),
//                         ],
//                       ),
//                       if (ref.watch(pickedImageProvider) != null)
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Image.file(
//                             ref.watch(pickedImageProvider)!,
//                             height: 200,
//                             width: 200,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 SubmitButton(
//                   isLoadingProvider: isLoadingProvider,
//                   onClick: () => submitComplaint(ref, user),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//     // },
//     // );
//   }
// }
// import 'package:complaint_portal/common/utils/enums.dart';
// import 'package:complaint_portal/common/utils/validators.dart';
// import 'package:complaint_portal/common/widgets/dropdown_dialog.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/complaint/providers/complaint_form_provider.dart';
// import 'package:complaint_portal/features/complaint/widgets/submit_complaint_form.dart';

// import 'package:complaint_portal/common/services/image_picker.dart';
// import 'package:complaint_portal/common/utils/constants.dart';
// import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
// import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
// import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// class ComplaintForm extends ConsumerStatefulWidget {
//   const ComplaintForm({super.key});

//   @override
//   ConsumerState<ComplaintForm> createState() => _ComplaintFormState();
// }

// class _ComplaintFormState extends ConsumerState<ComplaintForm> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.watch(hostelProvider.notifier).state =
//           ref.watch(userProvider).hostel!.value;
//       ref.watch(roomNoProvider.notifier).state = ref.watch(userProvider).roomNo;
//       roomNoController.text = ref.watch(userProvider).roomNo ?? '';
//     });
//   }

//   late final TextEditingController roomNoController = TextEditingController();
//   late final TextEditingController descriptionController =
//       TextEditingController();
//   late final TextEditingController titleController = TextEditingController();
//   @override
//   void dispose() {
//     roomNoController.dispose();
//     descriptionController.dispose();
//     titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final UserModel user = ref.watch(userProvider);
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Form(
//             key: ref.watch(formKeyProvider),
//             child: Column(
//               children: [
//                 TextFormFieldItem(
//                   initValue: user.name,
//                   canEdit: false,
//                   labelText: 'Name',
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   initValue: user.email,
//                   labelText: 'Email',
//                   canEdit: false,
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   initValue: user.rollNo,
//                   labelText: 'Roll Number',
//                   canEdit: false,
//                   textCapitalization: TextCapitalization.characters,
//                 ),
//                 SizedBox(height: kFormSpacing * 0.5),
//                 customDropDownMenu(
//                   headerText: "Hostel:",
//                   context: context,
//                   hintText: 'Hostel',
//                   value: ref.watch(hostelProvider),
//                   items: Hostel.getHostels(),
//                   onChanged: (value) =>
//                       ref.watch(hostelProvider.notifier).state = value,
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   labelText: 'Hostel',
//                   controller: TextEditingController(
//                       text: ref.watch(hostelProvider).toString()),

//                   suffixIcon: FeatherIcons.chevronDown,
//                   canEdit: false,
//                   onSuffixTap: () async {
//                     final selected = await showDropDownDialog(
//                       title: 'Select Hostel',
//                       items: Hostel.values
//                           .map((e) => e.toString().split('.').last)
//                           .toList(),
//                     );
//                     if (selected != null) {
//                       ref.watch(hostelProvider.notifier).state = selected;
//                     }
//                   },
//                   //     );
//                   //   },
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   controller: roomNoController,
//                   onChanged: (value) {
//                     ref.watch(roomNoProvider.notifier).state = value;
//                   },
//                   labelText: 'Room No',
//                   validator: (String? value) {
//                     return isRoom(value);
//                   },
//                   allowDelete: true,
//                   onDelete: () {
//                     roomNoController.clear();
//                     ref.watch(roomNoProvider.notifier).state = null;
//                   },
//                   // suffixIcon: const Icon(
//                   //   FeatherIcons.trash2,
//                   //   size: 20,
//                   // ),
//                   // onSuffixTap: () {
//                   //   roomNoController.clear();
//                   //   ref.watch(roomNoProvider.notifier).state = null;
//                   // },
//                   // allowDelete: true,
//                 ),
//                 SizedBox(height: kFormSpacing * 0.5),
//                 customDropDownMenu(
//                   headerText: "Complaint Type:",
//                   context: context,
//                   hintText: 'Complaint Type',
//                   value: ref.watch(complaintTypeProvider),
//                   items: ['Individual', 'Common'],
//                   onChanged: (value) =>
//                       ref.watch(complaintTypeProvider.notifier).state = value,
//                 ),
                // SizedBox(height: kFormSpacing * 0.5),
                // customDropDownMenu(
                //   headerText: "Complaint Category:",
                //   context: context,
                //   hintText: 'Complaint Category',
                //   value: ref.watch(complaintCategoryProvider),
                //   items: complaintCategories,
                //   onChanged: (value) => ref
                //       .watch(complaintCategoryProvider.notifier)
                //       .state = value,
                // ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   onChanged: (value) {
//                     ref.watch(titleProvider.notifier).state = value;
//                   },
//                   controller: titleController,
//                   labelText: 'Title',
//                   validator: (String? value) {
//                     return isTitle(value);
//                   },
//                   allowDelete: true,
//                   onDelete: () {
//                     titleController.clear();
//                     ref.watch(titleProvider.notifier).state = null;
//                   },
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 TextFormFieldItem(
//                   labelText: 'Description',
//                   onChanged: (value) {
//                     ref.watch(descriptionProvider.notifier).state = value;
//                   },
//                   controller: descriptionController,
//                   validator: (String? value) {
//                     return isDescription(value);
//                   },
//                   allowDelete: true,
//                   onDelete: () {
//                     descriptionController.clear();
//                     ref.watch(descriptionProvider.notifier).state = null;
//                   },
//                   maxLines: 4,
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.rectangle,
//                     border: Border.all(color: Colors.black.withOpacity(0.3)),
//                     borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Text(
//                                 ref.watch(pickedImageProvider) == null
//                                     ? 'Upload an Image'
//                                     : "Uploaded Image",
//                                 style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF181D3D))),
//                           ),
//                           const Spacer(),
//                           ref.watch(pickedImageProvider) == null
//                               ? IconButton(
//                                   icon: const Icon(Icons.image),
//                                   onPressed: () async {
//                                     ref
//                                             .watch(pickedImageProvider.notifier)
//                                             .state =
//                                         await pickImage(ImageSource.gallery);
//                                   },
//                                 )
//                               : IconButton(
//                                   icon: const Icon(Icons.edit),
//                                   onPressed: () async {
//                                     ref
//                                             .watch(pickedImageProvider.notifier)
//                                             .state =
//                                         await pickImage(ImageSource.gallery);
//                                   },
//                                 ),
//                           ref.watch(pickedImageProvider) == null
//                               ? IconButton(
//                                   icon: const Icon(Icons.camera_alt),
//                                   onPressed: () async {
//                                     ref
//                                             .watch(pickedImageProvider.notifier)
//                                             .state =
//                                         await pickImage(ImageSource.camera);
//                                   },
//                                 )
//                               : IconButton(
//                                   icon: const Icon(Icons.delete),
//                                   onPressed: () => ref
//                                       .watch(pickedImageProvider.notifier)
//                                       .state = null,
//                                 ),
//                         ],
//                       ),
//                       if (ref.watch(pickedImageProvider) != null)
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Image.file(
//                             ref.watch(pickedImageProvider)!,
//                             height: 200,
//                             width: 200,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: kFormSpacing),
//                 SubmitButton(
//                   isLoadingProvider: isLoadingProvider,
//                   onClick: () => submitComplaint(ref, user),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//     // },
//     // );
//   }
// }
