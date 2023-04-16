import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/custom_app_bar.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/screens/edit_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
import 'package:complaint_portal/features/complaint/widgets/delete_complaint_dialogue.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../widgets/dialog.dart';

class ComplaintScreen extends ConsumerStatefulWidget {
  final Complaint complaint;
  const ComplaintScreen({
    super.key,
    required this.complaint,
  });

  @override
  ConsumerState<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends ConsumerState<ComplaintScreen> {
  bool _pdv = false;
  bool _cdv = true;
  bool _rdv = true;
  bool _adv = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Complaint complaint =
        ref.watch(complaintProvider(widget.complaint.cid!));
    final complaintUser =
        ref.watch(complaintUserProvider(widget.complaint.uid!));
    final UserModel user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            const Text('View Complaint'),
            const Spacer(),
            if ((complaint.status == 'pending' && complaintUser.id == user.id))
              InkWell(
                onTap: () async {
                  Get.to(
                    () => EditComplaintPage(
                      complaint: complaint,
                    ),
                  );
                },
                child: const Icon(
                  FeatherIcons.edit,
                ),
              ),
            const SizedBox(width: 5),
            if ((complaint.status == 'pending' &&
                    complaintUser.id == user.id) ||
                (user.isAdmin != null && user.isAdmin!))
              Consumer(
                builder: (context, ref, _) => IconButton(
                  icon: const Icon(FeatherIcons.trash2),
                  onPressed: () async {
                    final result = await deleteComplaintDialog(context);
                    if (result == true) {
                      await ref
                          .watch(complaintRepositoryProvider)
                          .deleteComplaint(complaint.cid!, ref);
                      Get.back();
                      Get.back();
                    }
                  },
                ),
              ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Personal Details",
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
                      Icons.arrow_drop_down_circle_outlined,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _pdv,
                child: Column(
                  children: [
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller:
                          TextEditingController(text: complaintUser.name),
                      canEdit: false,
                      labelText: 'Name',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller:
                          TextEditingController(text: complaintUser.email),
                      labelText: 'Email',
                      canEdit: false,
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller:
                          TextEditingController(text: complaintUser.rollNo),
                      labelText: 'Roll Number',
                      canEdit: false,
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ],
                ),
              ),
              SizedBox(height: kFormSpacing),
              Row(
                children: [
                  const Text(
                    "Complaint Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _cdv = !_cdv;
                      });
                    },
                    child: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _cdv,
                child: Column(
                  children: [
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller:
                          TextEditingController(text: complaint.cid.toString()),
                      canEdit: false,
                      labelText: 'ID',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller: TextEditingController(
                          text: complaint.date.toString()),
                      canEdit: false,
                      labelText: 'Date',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller: TextEditingController(
                          text: complaint.category.toString()),
                      canEdit: false,
                      labelText: 'Category',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller: TextEditingController(
                          text: complaint.title.toString()),
                      canEdit: false,
                      labelText: 'Title',
                      validator: (String? value) {
                        return isTitle(value);
                      },
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller: TextEditingController(
                          text: complaint.description.toString()),
                      canEdit: false,
                      labelText: 'Description',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller: TextEditingController(
                          text: complaint.hostel.toString()),
                      canEdit: false,
                      labelText: 'Hostel',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      canEdit: false,
                      textCapitalization: TextCapitalization.sentences,
                      controller: TextEditingController(
                          text: complaint.roomNo.toString()),
                      labelText: 'Room No',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      controller: TextEditingController(
                          text: complaint.complaintType.toString()),
                      canEdit: false,
                      labelText: 'Complaint Type',
                    ),
                    SizedBox(height: kFormSpacing),
                    TextFormFieldItem(
                      //     complaint.status.toString().capitalizeFirst,
                      controller: TextEditingController(
                          text: complaint.status.toString().capitalizeFirst),
                      canEdit: false,
                      labelText: 'Status',
                      textColor: complaint.status == 'pending'
                          ? Colors.orange
                          : complaint.status == 'resolved'
                              ? Colors.green
                              : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: kFormSpacing),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "Uploaded Image ",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        if (complaint.imageLink == null)
                                          const TextSpan(
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                            text: " :  No Image found",
                                          ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  if (complaint.imageLink != null)
                                    GestureDetector(
                                      onTap: () {
                                        //show image preview
                                        imageDialog(
                                          imageLink: complaint.imageLink!,
                                        );
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.image,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kFormSpacing),
              if (complaint.status == 'resolved')
                Row(
                  children: [
                    const Text(
                      "Resolved Details",
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
                          _rdv = !_rdv;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                      ),
                    ),
                  ],
                ),
              Visibility(
                visible: complaint.status == 'resolved' ||
                    complaint.status == 'rejected',
                child: Column(
                  children: [
                    Visibility(
                      visible: _rdv,
                      child: Column(
                        children: [
                          SizedBox(height: kFormSpacing),
                          if (complaint.resolvedAt != null)
                            TextFormFieldItem(
                              controller: TextEditingController(
                                text: complaint.resolvedAt?.toString(),
                              ),
                              canEdit: false,
                              labelText: 'Date',
                            ),
                          if (complaint.resolvedAt != null)
                            SizedBox(height: kFormSpacing),
                          if (complaint.resolvedBy != null &&
                              complaint.status == 'resolved')
                            TextFormFieldItem(
                              controller: TextEditingController(
                                text: complaint.resolvedBy.toString(),
                              ),
                              canEdit: false,
                              labelText: 'Resolved By',
                            ),
                          if (complaint.resolvedBy != null &&
                              complaint.status == 'resolved')
                            SizedBox(height: kFormSpacing),
                          GestureDetector(
                            onTap: () {
                              //open dialogue to display comment
                              if (complaint.comment != null) {
                                Get.dialog(
                                  Dialog(
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                "Comment",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SingleChildScrollView(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    complaint.comment ??
                                                        'No Comments',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: TextFormFieldItem(
                              controller: TextEditingController(
                                text: complaint.comment?.toString() ??
                                    'No Comments',
                              ),
                              canEdit: false,
                              labelText: 'Comment',
                            ),
                          ),
                          if (complaint.comment != null)
                            SizedBox(height: kFormSpacing),
                        ],
                      ),
                    ),
                    SizedBox(height: kFormSpacing),
                  ],
                ),
              ),
              Visibility(
                visible: user.isAdmin ?? false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Admin Actions",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _adv = !_adv;
                            });
                          },
                          child: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kFormSpacing),
                    if (_adv)
                      Center(
                        child: Column(
                          children: [
                            if (complaint.status == 'resolved')
                              CustomElevatedButton(
                                onClick: () {
                                  markAsPendingDialog(
                                      complaint: complaint, ref: ref);
                                },
                                text: "Mark as Pending",
                              ),
//
                            if (complaint.status == 'pending')
                              CustomElevatedButton(
                                onClick: () {
                                  markAsResolvedDialog(
                                    complaint: complaint,
                                    ref: ref,
                                    user: user,
                                  );
                                },
                                text: "Resolve Complaint",
                              ),
                            if (complaint.status == 'pending')
                              CustomElevatedButton(
                                onClick: () {
                                  markAsRejectedDialog(
                                    complaint: complaint,
                                    ref: ref,
                                  );
                                },
                                text: "Reject Complaint",
                              ),
                            if (complaint.status == 'rejected')
                              CustomElevatedButton(
                                onClick: () {
                                  markAsPendingDialog(
                                      complaint: complaint, ref: ref);
                                },
                                text: "Mark as Pending",
                              ),
                          ],
                        ),
                      ),
                    SizedBox(height: kFormSpacing * 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //     },
    //   );
  }
}

imageDialog({
  required String imageLink,
}) {
  Get.dialog(
    Dialog(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 300,
        width: 300,
        child: PhotoView(
          gestureDetectorBehavior: HitTestBehavior.opaque,
          backgroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          imageProvider: NetworkImage(
            imageLink,
          ),
          loadingBuilder: (context, event) => const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    ),
  );
}
// }

// //
