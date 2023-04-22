import 'package:complaint_portal/common/widgets/dialog.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/screens/edit/edit_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/widgets/dialog.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ViewComplaintAppBar extends StatelessWidget with PreferredSizeWidget {
  const ViewComplaintAppBar({
    super.key,
    required this.complaint,
    required this.complaintUser,
    required this.user,
  });

  final Complaint complaint;
  final UserModel complaintUser;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          if ((complaint.status == 'pending' && complaintUser.id == user.id) ||
              (user.isAdmin != null && user.isAdmin!))
            Consumer(
              builder: (context, ref, _) => IconButton(
                icon: const Icon(FeatherIcons.trash2),
                onPressed: () async {
                  // final result = await deleteComplaintDialog(context);
                  final result = await dialogResult("Delete Complaint",
                      "Are you sure you want to delete this complaint?");
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}