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

class ComplaintScreen extends ConsumerWidget {
  final String cid;
  const ComplaintScreen({
    super.key,
    required this.cid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Complaint complaint = ref.watch(complaintProvider(cid));
    final complaintUser = ref.watch(complaintUserProvider(complaint.uid!));
    final UserModel user = ref.watch(userProvider);
    return Scaffold(
      appBar: ViewComplaintAppBar(
          complaint: complaint, complaintUser: complaintUser, user: user),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
          child: Column(
            children: [
              PersonalDetailsSection(ref: ref, complaintUser: complaintUser),
              SizedBox(height: kFormSpacing),
              ComplaintDetailsSection(complaint: complaint),
              SizedBox(height: kFormSpacing),
              ResolvedDetailsSection(complaint: complaint),
              AdminActionsSectioon(user: user, complaint: complaint),
            ],
          ),
        ),
      ),
    );
    //     },
    //   );
  }
}