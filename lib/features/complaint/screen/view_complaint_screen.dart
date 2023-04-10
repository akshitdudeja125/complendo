import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/services/connectivity_service.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/delete_complaint_dialogue.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/complaint/screen/edit_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/screen/provider/complaint_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);

class ComplaintScreen extends StatefulWidget {
  final UserModel user;
  final Complaint complaint;
  const ComplaintScreen({
    super.key,
    required this.complaint,
    required this.user,
  });

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  bool _pdv = true;
  bool _cdv = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              const Text('View Complaint'),
              const Spacer(),
              InkWell(
                onTap: () async {
                  Get.to(
                    () => EditComplaintPage(
                      user: widget.user,
                      complaint: widget.complaint,
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                ),
              ),
              const SizedBox(width: 5),
              Consumer(
                builder: (context, ref, _) => IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final result = await deleteComplaintDialog(context);
                    if (result == true) {
                      await ref
                          .watch(complaintRepositoryProvider)
                          .deleteComplaint(widget.complaint.cid, ref);
                      Get.back();
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
            // padding: const EdgeInsets.all(40),
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
                    // down arrow to expand
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
                SizedBox(height: kFormSpacing),
                Visibility(
                  visible: _pdv,
                  child: Column(
                    children: [
                      TextFormFieldItem(
                        initValue: widget.user.name,
                        canEdit: false,
                        labelText: 'Name',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.user.email,
                        labelText: 'Email',
                        canEdit: false,
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.user.rollNo,
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
                Visibility(
                  visible: _cdv,
                  child: Column(
                    children: [
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.cid,
                        canEdit: false,
                        labelText: 'ID',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.date.toString(),
                        canEdit: false,
                        labelText: 'Date',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.category,
                        canEdit: false,
                        labelText: 'Category',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.title,
                        canEdit: false,
                        labelText: 'Title',
                        validator: (String? value) {
                          return isTitle(value);
                        },
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.description,
                        canEdit: false,
                        labelText: 'Description',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.hostel,
                        canEdit: false,
                        labelText: 'Hostel',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        canEdit: false,
                        textCapitalization: TextCapitalization.sentences,
                        initValue: widget.complaint.roomNo,
                        labelText: 'Room No',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.complaintType,
                        canEdit: false,
                        labelText: 'Complaint Type',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue:
                            widget.complaint.status.toString().capitalizeFirst,
                        canEdit: false,
                        labelText: 'Status',
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
                                          if (widget.complaint.imageLink ==
                                              null)
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
                                    if (widget.complaint.imageLink != null)
                                      GestureDetector(
                                        onTap: () {
                                          //show image preview
                                          imageDialog(
                                            imageLink:
                                                widget.complaint.imageLink!,
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
                            // if (widget.complaint.imageLink != null)
                            //   Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: IconButton(
                            //       onPressed: () {
                            //         //show image preview
                            //         imageDialog(
                            //           imageLink: widget.complaint.imageLink!,
                            //         );
                            //       },
                            //       icon: const Icon(
                            //         Icons.image,
                            //         size: 80,
                            //       ),
                            //     ),
                            //   ),
                            //   Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Container(
                            //       height: 250,
                            //       width: 250,
                            //       child: PhotoView(
                            //         gestureDetectorBehavior:
                            //             HitTestBehavior.opaque,
                            //         backgroundDecoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(20),
                            //           border: Border.all(
                            //             color: Colors.black.withOpacity(0.3),
                            //           ),
                            //         ),
                            //         imageProvider: NetworkImage(
                            //           widget.complaint.imageLink!,
                            //         ),
                            //         loadingBuilder: (context, event) =>
                            //             const Center(
                            //           child: SizedBox(
                            //             width: 20.0,
                            //             height: 20.0,
                            //             child: CircularProgressIndicator(),
                            //           ),
                            //         ),
                            //       ),
                            // decoration: BoxDecoration(
                            // image: DecorationImage(

                            // image: Image.network(
                            //   widget.complaint.imageLink!,
                            //   // height: 200,
                            //   frameBuilder: (context, child, frame,
                            //       wasSynchronouslyLoaded) {
                            //     return child;
                            //   },
                            //   loadingBuilder:
                            //       (context, child, loadingProgress) {
                            //     if (loadingProgress == null) {
                            //       return child;
                            //     } else {
                            //       return const Center(
                            //         child:
                            //             CircularProgressIndicator(),
                            //       );
                            //     }
                            //   },
                            // ).image,
                            // fit: BoxFit.,
                            // ),
                            //   shape: BoxShape.rectangle,
                            //   border: Border.all(
                            //       color: Colors.black.withOpacity(0.3)),
                            //   borderRadius: BorderRadius.circular(20),
                            // ),
                            // ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kFormSpacing * 2),
              ],
            ),
          ),
        ));
  }
}

imageDialog({
  required String imageLink,
}) {
  Get.dialog(
    Dialog(
      clipBehavior: Clip.antiAlias,
      child: Container(
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
