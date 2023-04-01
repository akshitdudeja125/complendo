import 'package:complaint_portal/features/complaint/screen/complaint_screen.dart';
import 'package:complaint_portal/features/complaint/screen/edit/edit_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/screen/provider/complaint_provider.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintScreen(
                      complaint: complaint,
                    ),
                  ),
                );
              },
            ),
            // Visibility(
            //   visible: complaint.status == 'pending',
            // child: Column(
            //   children: [
            if (complaint.status == 'pending')
              ListTile(
                // textColor: Colors.grey,
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
                  // Navigator.pop(context);
                },
              ),
            if (complaint.status == 'pending')
              ListTile(
                // textColor: Colors.grey,
                title: const Text('Delete'),
                onTap: () {
                  ref
                      .read(complaintRepositoryProvider)
                      .deleteComplaint(complaint.cid, ref);
                  Navigator.pop(context);
                },
              ),
            //   ],
            // ),
            // ),
            // ListTile(
            //   // textColor: Colors.grey,
            //   textColor:
            //       complaint.status == 'pending' ? Colors.grey : Colors.black,
            //   title: const Text('Edit'),
            //   onTap: () {},
            // ),
            // ListTile(
            //   // textColor: Colors.grey,
            //   textColor:
            //       complaint.status == 'pending' ? Colors.grey : Colors.black,
            //   title: const Text('Delete'),
            //   onTap: () {
            //     ref
            //         .read(complaintRepositoryProvider)
            //         .deleteComplaint(complaint.cid, ref);
            //     Navigator.pop(context);
            //   },
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      });
}
