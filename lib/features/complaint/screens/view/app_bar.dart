import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/dialog.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/screens/edit/edit_complaint_screen.dart';
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
      backgroundColor: ThemeColors.appBarColor[Theme.of(context).brightness],
      title: Row(
        children: [
          Text(
            'View Complaint',
            style: TextStyles(Theme.of(context).brightness).appbarTextStyle,
          ),
          const Spacer(),
          if ((complaint.status == ComplaintStatus.pending &&
                  complaintUser.id == user.id ||
              (user.userType! == UserType.admin)))
            InkWell(
              onTap: () async {
                Get.to(
                  () => EditComplaintPage(
                    complaint: complaint,
                  ),
                );
              },
              child: Icon(
                FeatherIcons.edit,
                color:
                    ThemeColors.dropDownIconColor[Theme.of(context).brightness],
              ),
            ),
          const SizedBox(width: 5),
          if ((complaint.status == ComplaintStatus.pending &&
                  complaintUser.id == user.id) ||
              (user.userType!.value != 'student'))
            Consumer(
              builder: (context, ref, _) => IconButton(
                icon: Icon(
                  FeatherIcons.trash2,
                  color: ThemeColors
                      .dropDownIconColor[Theme.of(context).brightness],
                ),
                onPressed: () async {
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
        icon: Icon(
          FeatherIcons.arrowLeft,
          color: ThemeColors.dropDownIconColor[Theme.of(context).brightness],
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
