import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/features/complaint/screens/view_complaint_screen.dart';
import 'package:complaint_portal/features/complaint/widgets/bottom_sheet.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
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
        Get.to(() => ComplaintScreen(
              complaint: complaint,
            ));
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              categoryImageMap[complaint.category] == null
                  ? const Icon(
                      Icons.error,
                      size: 40,
                    )
                  : Image(
                      height: 40,
                      width: 40,
                      image: AssetImage(
                        categoryImageMap[complaint.category] ??
                            'assets/images/complaint_icons/electric.png',
                      ),
                    ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complaint.title!.substring(0, 1).toUpperCase() +
                        complaint.title!.substring(1),
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
                        complaint.hostel!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  complaint.status == null
                      ? const SizedBox()
                      : Text(
                          complaint.status!.toUpperCase().toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: complaint.status == 'pending'
                                ? const Color.fromARGB(255, 195, 119, 5)
                                : complaint.status == 'resolved'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                ],
              ),
              const Spacer(),
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
        ),
      ),
    );
  }
}
