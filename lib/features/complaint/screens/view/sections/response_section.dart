import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/utils/extensions.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/complaint/screens/view/provider/section_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ResolvedDetailsSection extends ConsumerWidget {
  const ResolvedDetailsSection({super.key, required this.complaint});

  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (complaint.status != ComplaintStatus.pending) {
      return Column(
        children: [
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
                  ref.watch(rdProvider.notifier).state =
                      !ref.watch(rdProvider.notifier).state;
                },
                child: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                ),
              ),
            ],
          ),
          Consumer(builder: (context, ref, _) {
            final rdv = ref.watch(rdProvider);
            return Visibility(
              visible: complaint.status != ComplaintStatus.pending,
              child: Column(
                children: [
                  Visibility(
                    visible: rdv,
                    child: Column(
                      children: [
                        SizedBox(height: kFormSpacing),
                        if (complaint.resolvedAt != null)
                          TextFormFieldItem(
                            controller: TextEditingController(
                              // text: complaint.resolvedAt?.toString(),
                              text: complaint.resolvedAt == null
                                  ? ""
                                  : complaint.resolvedAt!.formattedDate,
                            ),
                            canEdit: false,
                            labelText: 'Date',
                          ),
                        if (complaint.resolvedAt != null)
                          SizedBox(height: kFormSpacing),
                        if (complaint.resolvedBy != null &&
                            complaint.status == ComplaintStatus.resolved)
                          TextFormFieldItem(
                            controller: TextEditingController(
                              text: complaint.resolvedBy.toString(),
                            ),
                            canEdit: false,
                            labelText: 'Resolved By',
                          ),
                        if (complaint.resolvedBy != null &&
                            complaint.status == ComplaintStatus.resolved)
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
                                            padding: const EdgeInsets.all(10.0),
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
            );
          }),
        ],
      );
    }
    return const SizedBox();
  }
}
