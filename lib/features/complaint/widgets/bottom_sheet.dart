import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/dialog.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/screens/view/view_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/screens/edit/edit_complaint_screen.dart';

import 'package:complaint_portal/features/complaint/widgets/dialog.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

complaintBottomModelSheet(
    BuildContext context, Complaint complaint, WidgetRef ref, UserModel user) {
  return showModalBottomSheet(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.white,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('View Details'),
              onTap: () => Get.to(() => ComplaintScreen(
                    complaint: complaint,
                  )),
            ),
            if (complaint.status == ComplaintStatus.pending &&
                (complaint.uid == user.id || user.userType!.value != 'student'))
              ListTile(
                title: const Text('Edit'),
                onTap: () => Get.to(
                  () => EditComplaintPage(complaint: complaint),
                ),
              ),
            if ((complaint.status == ComplaintStatus.pending &&
                    complaint.uid == user.id) ||
                user.userType!.value != 'student')
              ListTile(
                title: const Text('Delete'),
                onTap: () async {
                  final result = await dialogResult("Delete Complaint",
                      "Are you sure you want to delete this complaint?");
                  if (result == true) {
                    await ref
                        .watch(complaintRepositoryProvider)
                        .deleteComplaint(complaint.cid!, ref);
                  }
                  Get.back();
                  Get.back();
                },
              ),
            if (user.userType!.value != 'student' &&
                complaint.status == ComplaintStatus.pending)
              ListTile(
                  title: const Text('Mark as Resolved'),
                  onTap: () {
                    Get.back();
                    markAsResolvedDialog(
                      complaint: complaint,
                      ref: ref,
                      user: user,
                    );
                  }),
            if (user.userType!.value != 'student' &&
                complaint.status == ComplaintStatus.pending)
              ListTile(
                  title: const Text('Reject'),
                  onTap: () {
                    Get.back();
                    markAsRejectedDialog(
                      complaint: complaint,
                      ref: ref,
                    );
                  }),
            if (user.userType!.value != 'student' &&
                complaint.status == ComplaintStatus.rejected)
              ListTile(
                title: const Text('Mark as Pending'),
                onTap: () {
                  Get.back();
                  markAsPendingDialog(
                    complaint: complaint,
                    ref: ref,
                  );
                },
              ),
            if (user.userType!.value != 'student' &&
                complaint.status == ComplaintStatus.resolved)
              ListTile(
                title: const Text('Mark as Pending'),
                onTap: () {
                  Get.back();
                  markAsPendingDialog(
                    complaint: complaint,
                    ref: ref,
                  );
                },
              ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      });
}
