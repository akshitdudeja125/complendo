import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/features/complaint/submit_complaint_form.dart';
import 'package:complaint_portal/providers/complaint_form_provider.dart';
import 'package:complaint_portal/providers/user_provider.dart';
import 'package:complaint_portal/screens/error_screen.dart';
import 'package:complaint_portal/screens/image_picker.dart';
import 'package:complaint_portal/screens/loading_screen.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintForm extends ConsumerWidget {
  const ComplaintForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data =
        ref.watch(userDataStreamProvider(ref.watch(authUserProvider)!.uid));
    return data.when(
      error: (e, trace) => ErrorScreen(e, trace),
      loading: () => const LoadingScreen(),
      data: (value) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: ref.watch(formKeyProvider),
              child: Column(
                children: [
                  TextFormFieldItem(
                    initValue: value!['name'],
                    canEdit: false,
                    labelText: 'Name',
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    initValue: value['email'],
                    labelText: 'Email',
                    canEdit: false,
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    initValue: value['rollNo'],
                    labelText: 'Roll Number',
                    // canEdit: false,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  SizedBox(height: kFormSpacing * 0.59),
                  customDropDownMenu(
                    context: context,
                    headerText: "Hostel:",
                    items: hostels,
                    hintText: "Select Hostel",
                    value: ref.watch(hostelProvider),
                    onChanged: (value) =>
                        ref.watch(hostelProvider.notifier).state = value,
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    // controller: ref.watch(roomNoControllerProvider),
                    onChanged: (value) {
                      ref.watch(roomNoProvider.notifier).state = value;
                    },
                    // keyboardType: TextInputType.number,
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
                    value: ref.watch(complaintTypeProvider),
                    items: ['Individual', 'Common'],
                    onChanged: (value) =>
                        ref.watch(complaintTypeProvider.notifier).state = value,
                  ),
                  SizedBox(height: kFormSpacing),
                  customDropDownMenu(
                    headerText: "Complaint Category:",
                    context: context,
                    hintText: 'Complaint Category',
                    value: ref.watch(complaintCategoryProvider),
                    items: complaintCategories,
                    onChanged: (value) => ref
                        .watch(complaintCategoryProvider.notifier)
                        .state = value,
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    onChanged: (value) {
                      ref.watch(titleProvider.notifier).state = value;
                    },
                    labelText: 'Title',
                    validator: (String? value) {
                      return isTitle(value);
                    },
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    labelText: 'Description',
                    onChanged: (value) {
                      ref.watch(descriptionProvider.notifier).state = value;
                    },
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
                                  ref.watch(pickedImageProvider) == null
                                      ? 'Upload an Image'
                                      : "Uploaded Image",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF181D3D))),
                            ),
                            const Spacer(),
                            ref.watch(pickedImageProvider) == null
                                ? IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    onPressed: () {
                                      pickImage(ImageSource.camera, ref);
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => ref
                                        .watch(pickedImageProvider.notifier)
                                        .state = null,
                                  ),
                            ref.watch(pickedImageProvider) == null
                                ? IconButton(
                                    icon: const Icon(Icons.image),
                                    onPressed: () {
                                      pickImage(ImageSource.gallery, ref);
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      pickImage(ImageSource.gallery, ref);
                                    },
                                  )
                          ],
                        ),
                        if (ref.watch(pickedImageProvider) != null)
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.file(
                              ref.watch(pickedImageProvider)!,
                              height: 200,
                              width: 200,
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: kFormSpacing),
                  SubmitButton(
                    isLoadingProvider: isLoadingProvider,
                    onClick: () => submitComplaint(ref),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
