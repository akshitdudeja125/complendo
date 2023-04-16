import 'package:complaint_portal/common/widgets/custom_app_bar.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
import 'package:complaint_portal/features/profile/image_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../models/user_model.dart';
import 'edit_profile.dart';
import 'personal_information.dart';

class StudentProfile extends ConsumerStatefulWidget {
  const StudentProfile({
    super.key,
  });

  @override
  ConsumerState<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends ConsumerState<StudentProfile> {
  bool _pdv = true;
  bool _cdv = false;

  @override
  Widget build(BuildContext context) {
    final UserModel user = ref.watch(userProvider);
    return Scaffold(
      appBar: CustomAppBar(
        heading: "Profile",
        trailing: IconButton(
          onPressed: () {
            Get.to(() => const EditProfile());
          },
          icon: const Icon(FeatherIcons.edit),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Column(
            children: [
              if (user.photoURL != null)
                Center(
                  child: InkWell(
                    onTap: () {
                      showDefaultPopup(
                          context: context, images: [user.photoURL!]);
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        user.photoURL!,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Column(
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    user.isAdmin! ? "Admin" : "Student",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _pdv = !_pdv;
                            });
                          },
                          child: const Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    if (_pdv) PersonalImformation(user: user),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Complaint Data",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        // down arrow to expand
                        InkWell(
                          onTap: () {
                            setState(() {
                              _cdv = !_cdv;
                            });
                          },
                          child: const Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    if (_cdv)
                      Column(
                        children: [
                          TextFormFieldItem(
                            controller: TextEditingController(
                              text: user.complaints?.length.toString() ?? '0',
                            ),
                            labelText: 'Complaints Registered',
                            canEdit: false,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Consumer(builder: (context, ref, _) {
                            final pendingRequestsAsyncValue =
                                ref.watch((pendingRequestsProvider));
                            return pendingRequestsAsyncValue.when(
                              data: (value) {
                                return TextFormFieldItem(
                                  controller: TextEditingController(
                                    text: value.toString(),
                                  ),
                                  labelText: 'Pending Complaints',
                                  canEdit: false,
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (error, stackTrace) =>
                                  Text(error.toString()),
                            );
                          }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




                          // StreamBuilder(
                            //     stream: FirebaseFirestore.instance
                            //         .collection('complaints')
                            //         .where('status', isEqualTo: 'pending')
                            //         .where('uid', isEqualTo: user.id)
                            //         .snapshots(),
                            //     builder: (context, snapshot) {
                            //       if (snapshot.connectionState ==
                            //           ConnectionState.waiting) {
                            //         return const Center(
                            //           child: CircularProgressIndicator(),
                            //         );
                            //       }
                            //       final pendingRequests = snapshot.data!.docs
                            //           .where((element) =>
                            //               element['status'] == 'pending')
                            //           .length;
                            //       return TextFormFieldItem(
                            //         controller: TextEditingController(
                            //           text: pendingRequests.toString(),
                            //         ),
                            //         labelText: 'Pending Complaints',
                            //         canEdit: false,
                            //       );
                            //     }),