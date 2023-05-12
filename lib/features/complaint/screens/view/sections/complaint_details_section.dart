import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/utils/extensions.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/complaint/screens/view/provider/section_provider.dart';
import 'package:complaint_portal/common/widgets/image_dialog.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ComplaintDetailsSection extends ConsumerWidget {
  const ComplaintDetailsSection({super.key, required this.complaint});

  final Complaint complaint;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Complaint Details",
              // style: TextStyle(
              //   fontSize: 18,
              //   fontWeight: FontWeight.bold,
              // ),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                ref.read(cdProvider.notifier).state =
                    !ref.read(cdProvider.notifier).state;
              },
              child: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
        Consumer(builder: (context, ref, _) {
          final cdv = ref.watch(cdProvider);
          return Visibility(
            visible: cdv,
            // visible: ref.watch(cdProvider),
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
                      text: complaint.date == null
                          ? ""
                          : complaint.date!.formattedDate),
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
                  controller:
                      TextEditingController(text: complaint.title.toString()),
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
                  controller:
                      TextEditingController(text: complaint.hostel.toString()),
                  canEdit: false,
                  labelText: 'Hostel',
                ),
                SizedBox(height: kFormSpacing),
                TextFormFieldItem(
                  canEdit: false,
                  textCapitalization: TextCapitalization.sentences,
                  controller:
                      TextEditingController(text: complaint.roomNo.toString()),
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
                  textColor: complaint.status == ComplaintStatus.pending
                      ? Colors.orange
                      : complaint.status == ComplaintStatus.resolved
                          ? Colors.green
                          : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: kFormSpacing),
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      // color: Colors.black.withOpacity(0.3),
                      color: Theme.of(context).dividerColor,
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
                                  // style: const TextStyle(
                                  //   fontSize: 13,
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      Icons.image,
                                      color: Theme.of(context).iconTheme.color,
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
          );
        }),
      ],
    );
  }
}
