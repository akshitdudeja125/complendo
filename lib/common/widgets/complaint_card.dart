import 'package:complaint_portal/common/widgets/bottom_sheet.dart';
import 'package:complaint_portal/features/complaint/screen/view_complaint_screen.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ComplaintCard extends ConsumerWidget {
  final UserModel user;
  const ComplaintCard({
    Key? key,
    required this.user,
    required this.complaint,
  }) : super(key: key);

  // final QueryDocumentSnapshot<Object?> complaint;
  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () => bottomModelSheet(context, complaint, ref, user),
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
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                complaint.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    complaint.category!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  complaint.date == null
                      ? const SizedBox()
                      : Text(
                          DateFormat.yMMMd().format(complaint.date!).toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 8),
              complaint.status == null
                  ? const SizedBox()
                  : Text(
                      complaint.status.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
