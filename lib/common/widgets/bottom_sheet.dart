import 'package:complaint_portal/features/complaint/screen/complaint_screen.dart';
import 'package:complaint_portal/providers/complaint_provider.dart';
import 'package:flutter/material.dart';

Future<dynamic> bottomModelSheet(context, complaint, ref) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('View Details'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintScreen(
                      complaintId: complaint.id,
                    ),
                  ),
                );
              },
            ),
            Visibility(
              visible: complaint['status'] == "Pending",
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Edit'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Delete'),
                    onTap: () {
                      ref
                          .read(complaintRepositoryProvider)
                          .deleteComplaint(complaint.id, ref);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      });
}
