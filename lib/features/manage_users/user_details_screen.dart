import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/custom_app_bar.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
import 'package:complaint_portal/features/profile/edit_profile.dart';
import 'package:complaint_portal/features/profile/image_detail_screen.dart';
import 'package:complaint_portal/features/profile/personal_information.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const UserDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  bool _pdv = true;
  bool _cdv = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      appBar: CustomAppBar(
        heading: "User Details",
        trailing: IconButton(
          onPressed: () {
            Get.to(() => EditProfile(
                  user: user,
                ));
          },
          icon: Icon(
            FeatherIcons.edit,
            // color: Theme.of(context).iconTheme.color,
            color: ThemeColors.iconColor[Theme.of(context).brightness],
          ),
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
                      radius: 50,
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
                    // style: Theme.of(context).textTheme.titleLarge,
                    style: TextStyles(Theme.of(context).brightness)
                        .settingsTitleTextStyle2,
                  ),
                  Text(
                    // user.isAdmin! ? "Admin" : "Student",
                    user.userType!.value.capitalize!,
                    // style: Theme.of(context).textTheme.titleSmall,
                    style: TextStyles(Theme.of(context).brightness)
                        .settingsSubtitleTextStyle2,
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
                        Text(
                          "Personal Information",
                          // style: TextStyle(
                          //   fontSize: 18,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          // detailsTextStyle
                          style: TextStyles(Theme.of(context).brightness)
                              .detailsTextStyle,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _pdv = !_pdv;
                            });
                          },
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: ThemeColors
                                .iconColor[Theme.of(context).brightness],
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
                    if (user.userType == UserType.student)
                      Row(
                        children: [
                          Text(
                            "Complaint Data",
                            style: TextStyles(Theme.of(context).brightness)
                                .detailsTextStyle,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _cdv = !_cdv;
                              });
                            },
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: ThemeColors
                                  .iconColor[Theme.of(context).brightness],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    if (user.userType == UserType.student)
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
