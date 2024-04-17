import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';

import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/screens/view/app_bar.dart';
import 'package:complaint_portal/features/complaint/screens/view/sections/admin_actions_sections.dart';
import 'package:complaint_portal/features/complaint/screens/view/sections/complaint_details_section.dart';
import 'package:complaint_portal/features/complaint/screens/view/sections/response_section.dart';
import 'package:complaint_portal/features/complaint/screens/view/sections/user_section.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  Widget build(BuildContext context) {
    final Complaint complaint =
        ref.watch(complaintProvider(widget.complaint.cid!));
    final complaintUser =
        ref.watch(complaintUserProvider(widget.complaint.uid!));
    final UserModel user = ref.watch(userProvider);
    return Scaffold(
      appBar: ViewComplaintAppBar(
        complaint: complaint,
        complaintUser: complaintUser,
        user: user,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, top: 16),
          child: Column(
            children: [
              PersonalDetailsSection(ref: ref, complaintUser: complaintUser),
              const SizedBox(height: kFormSpacing),
              ComplaintDetailsSection(complaint: complaint),

              if (complaint.complaintType == "Common")
                const SizedBox(height: kFormSpacing),
              if (complaint.complaintType == "Common")
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                          bgColor: (complaint.upvotes ?? []).contains(user.id)
                              ? Colors.green
                              : Colors.white,
                          textColor: (complaint.upvotes ?? []).contains(user.id)
                              ? Colors.white
                              : Colors.black,
                          onClick: () async {
                            if (complaint.uid == user.id) {
                              displaySnackBar('Failure',
                                  "Cannot upvote your own complaint");
                            } else if (complaint.status ==
                                ComplaintStatus.resolved) {
                              displaySnackBar('Failure',
                                  "Cannot upvote a resolved complaint");
                            } else if (complaint.status ==
                                ComplaintStatus.rejected) {
                              displaySnackBar('Failure',
                                  "Cannot upvote a rejected complaint");
                            } else {
                              await ref
                                  .watch(complaintRepositoryProvider)
                                  .upvoteComplaint(complaint.cid!, ref);
                            }
                          },
                          text:
                              "Upvote (${((complaint.upvotes ?? []).length)})"),
                      const SizedBox(width: 10),
                      CustomElevatedButton(
                          onClick: () async {
                            if (complaint.uid == user.id) {
                              displaySnackBar('Failure',
                                  "Cannot downvote your own complaint");
                            } else if (complaint.status ==
                                ComplaintStatus.resolved) {
                              displaySnackBar('Failure',
                                  "Cannot downvote a resolved complaint");
                            } else if (complaint.status ==
                                ComplaintStatus.rejected) {
                              displaySnackBar('Failure',
                                  "Cannot downvote a rejected complaint");
                            } else {
                              await ref
                                  .watch(complaintRepositoryProvider)
                                  .downVoteComplaint(complaint.cid!, ref);
                            }
                          },
                          bgColor: (complaint.downvotes ?? []).contains(user.id)
                              ? Colors.red
                              : Colors.white,
                          textColor:
                              (complaint.downvotes ?? []).contains(user.id)
                                  ? Colors.white
                                  : Colors.black,
                          text:
                              "Downvote (${((complaint.downvotes ?? []).length)})"),
                    ],
                  ),
                ),

              // if (complaint.status != ComplaintStatus.resolved &&
              //     !complaint.votes!.contains(user.id))
              //   CustomElevatedButton(
              //     onClick: () {},
              //     text: "Downvote",
              //   ),
              const SizedBox(height: kFormSpacing),
              ResolvedDetailsSection(complaint: complaint),
              AdminActionsSection(user: user, complaint: complaint),
            ],
          ),
        ),
      ),
    );
    //     },
    //   );
  }
}
