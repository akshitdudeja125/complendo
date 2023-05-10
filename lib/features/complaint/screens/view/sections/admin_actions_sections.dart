import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/features/complaint/screens/view/provider/section_provider.dart';
import 'package:complaint_portal/features/complaint/widgets/dialog.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminActionsSection extends ConsumerWidget {
  const AdminActionsSection({
    super.key,
    required this.user,
    required this.complaint,
  });

  final UserModel user;
  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      // visible: user.isAdmin ?? false,
      visible: user.userType!.value != 'student',
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
                  ref.read(adProvider.notifier).state =
                      !ref.read(adProvider.notifier).state;
                },
                child: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                ),
              ),
            ],
          ),
          SizedBox(height: kFormSpacing),
          Consumer(builder: (context, ref, _) {
            final adv = ref.watch(adProvider);
            return Visibility(
              visible: adv,
              child: Center(
                child: Column(
                  children: [
                    if (complaint.status == ComplaintStatus.resolved)
                      CustomElevatedButton(
                        onClick: () {
                          markAsPendingDialog(complaint: complaint, ref: ref);
                        },
                        text: "Mark as Pending",
                      ),
                    //
                    if (complaint.status == ComplaintStatus.pending)
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
                    if (complaint.status == ComplaintStatus.pending)
                      CustomElevatedButton(
                        onClick: () {
                          markAsRejectedDialog(
                            complaint: complaint,
                            ref: ref,
                          );
                        },
                        text: "Reject Complaint",
                      ),
                    if (complaint.status == ComplaintStatus.rejected)
                      CustomElevatedButton(
                        onClick: () {
                          markAsPendingDialog(complaint: complaint, ref: ref);
                        },
                        text: "Mark as Pending",
                      ),
                    if (complaint.status != ComplaintStatus.pending)
                      CustomElevatedButton(
                        onClick: () {
                          changeCommentDialog(
                            complaint: complaint,
                            ref: ref,
                            status: complaint.status == ComplaintStatus.rejected
                                ? 'rejected'
                                : 'resolved',
                          );
                        },
                        text: "Edit Comment",
                      ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: kFormSpacing * 2),
        ],
      ),
    );
  }
}
