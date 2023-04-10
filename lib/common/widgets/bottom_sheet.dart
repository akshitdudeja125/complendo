import 'package:complaint_portal/common/widgets/delete_complaint_dialogue.dart';
import 'package:complaint_portal/features/complaint/screen/view_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/screen/edit_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/screen/provider/complaint_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'change_complaint_status.dart';

bottomModelSheet(
    BuildContext context, Complaint complaint, WidgetRef ref, UserModel user) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('View Details'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintScreen(
                      user: user,
                      complaint: complaint,
                    ),
                  ),
                );
              },
            ),
            if (complaint.status == 'pending')
              ListTile(
                title: const Text('Edit'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditComplaintPage(
                        complaint: complaint,
                        user: user,
                      ),
                    ),
                  );
                },
              ),
            if (complaint.status == 'pending')
              ListTile(
                title: const Text('Delete'),
                onTap: () async {
                  final result = await deleteComplaintDialog(context);
                  if (result == true) {
                    await ref
                        .watch(complaintRepositoryProvider)
                        .deleteComplaint(complaint.cid, ref);
                  }
                  Get.back();
                  Get.back();

                  // ref
                  //     .read(complaintRepositoryProvider)
                  //     .deleteComplaint(complaint.cid, ref);
                  // Navigator.pop(context);
                },
              ),
            if (user.isAdmin! && complaint.status == 'pending')
              ListTile(
                title: const Text('Mark as Resolved'),
                onTap: () {
                  changeComplaintStaus(complaint, ref);
                },
              ),
            if (user.isAdmin! && complaint.status == 'resolved')
              ListTile(
                title: const Text('Mark as Pending'),
                onTap: () {
                  changeComplaintStaus(complaint, ref);
                  Navigator.pop(context);
                },
              ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      });
}
