import 'package:complaint_portal/utils/constants.dart';
// import 'package:complaint_portal/utils/validators.dart';
import 'package:complaint_portal/widgets/clipper.dart';
import 'package:complaint_portal/widgets/drop_down_list.dart';
import 'package:complaint_portal/widgets/text_form_field_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/validators.dart';

class ComposeComplaint extends StatefulWidget {
  const ComposeComplaint({super.key});

  @override
  State<ComposeComplaint> createState() => ComposeComplaintState();
}

class ComposeComplaintState extends State<ComposeComplaint> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // print(user);
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

class ComplaintController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final images = [].obs;
  final filingTime = DateTime.now().obs;
  final status = 'Pending'.obs;
  final upvotes = [].obs;
  final uid = "".obs;
  final dropDownValue = 'Select'.obs;
  final dropDownList = [];
  @override
  void onInit() {
    nameController.text = FirebaseAuth.instance.currentUser!.displayName!;
    emailController.text = FirebaseAuth.instance.currentUser!.email!;
    uid.value = FirebaseAuth.instance.currentUser!.uid;
    dropDownList.addAll(complaintCategories);
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  late final _formKey;
  late User user;
  final ComplaintController controller = Get.put(ComplaintController());

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    controller.formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: controller.formKey,
        child: Column(children: [
          TextFormFieldItem(
            controller: controller.nameController,
            canEdit: false,
            labelText: 'Name',
          ),
          SizedBox(height: kFormSpacing),
          TextFormFieldItem(
            controller: controller.emailController,
            labelText: 'Email',
            canEdit: false,
          ),
          SizedBox(height: kFormSpacing),
          TextFormFieldItem(
            controller: controller.titleController,
            labelText: 'Title',
            validator: (String? value) {
              return isTitle(value);
            },
          ),
          SizedBox(height: kFormSpacing),
          TextFormFieldItem(
            controller: controller.descriptionController,
            labelText: 'Description',
            validator: (String? value) {
              return isDescription(value);
            },
            maxLines: 4,
          ),
          SizedBox(height: kFormSpacing),
          DropDownList(
            dropDownList: complaintCategories,
            controller: controller,
          ),
          SizedBox(height: kFormSpacing),
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
              if (controller.dropDownValue.value == 'Select') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a category'),
                  ),
                );
              } else if (controller.formKey.currentState!.validate()) {
                // print('Validated');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Processing Data'),
                  ),
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}



          // const SizedBox(height: 20),
          // Container(
          //   decoration: BoxDecoration(
          //     shape: BoxShape.rectangle,
          //     border: Border.all(color: Colors.black.withOpacity(0.3)),
          //     borderRadius: const BorderRadius.all(Radius.circular(20)),
          //   // ),
          //   //   //   child: DropdownButtonHideUnderline(
          //   //   //     child: DropdownButton<String>(
          //   //   //         hint: Container(
          //   //   //           padding: const EdgeInsets.symmetric(horizontal: 11),
          //   //   //           child: Text(
          //   //   //             'Hostel',
          //   //   //             style: Theme.of(context)
          //   //   //                 .textTheme
          //   //   //                 .bodyMedium
          //   //   //                 ?.copyWith(fontSize: 16),
          //   //   //           ),
          //   //   //         ),
          //   //   //         // value: hostelName,
          //   //   //         value: controller.dropDownValue.value,
          //   //   //         onChanged: (String? value) {
          //   //   //           setState(() {
          //   //   //             controller.dropDownValue.value = value!;
          //   //   //           });
          //   //   //         },
          //   //   //         isExpanded: true,
          //   //   //         style: Theme.of(context).textTheme.bodyLarge,
          //   //   //         items: <String>["Select", ...complaintCategories]
          //   //   //             .map((String value) {
          //   //   //           return DropdownMenuItem<String>(
          //   //   //             value: value,
          //   //   //             child: Container(
          //   //   //               padding: const EdgeInsets.symmetric(horizontal: 11),
          //   //   //               child: Text(
          //   //   //                 value,
          //   //   //                 style: Theme.of(context)
          //   //   //                     .textTheme
          //   //   //                     .bodyMedium
          //   //   //                     ?.copyWith(fontSize: 16),
          //   //   //               ),
          //   //   //             ),
          //   //   //           );
          //   //   //         }).toList()),
          //   //   //   ),
          // ),