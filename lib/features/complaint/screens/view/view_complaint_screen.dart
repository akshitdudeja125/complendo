import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';

import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
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
              SizedBox(height: kFormSpacing),
              ComplaintDetailsSection(complaint: complaint),
              SizedBox(height: kFormSpacing),
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
