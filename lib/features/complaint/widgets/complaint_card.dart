import 'package:complaint_portal/common/theme/theme_provider.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/features/complaint/screens/view/view_complaint_screen.dart';
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

  final Complaint complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () => bottomModelSheet(context, complaint, ref, user),
      onTap: () {
        Get.to(() => ComplaintScreen(
              cid: complaint.cid!,
            ));
      },
      child: Card(
        color: ref.watch(isDarkProvider) ? Colors.grey[900] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.5),
                child: categoryImageMap[complaint.category] == null
                    ? const Icon(
                        Icons.error,
                        size: 40,
                        color: Colors.red,
                      )
                    : Image(
                        height: 40,
                        width: 40,
                        //set color only in dark mode
                        // color: ref.watch(isDarkProvider)
                        // ? Colors.white
                        // : Colors.black,

                        image: AssetImage(
                          categoryImageMap[complaint.category]!,
                        ),
                      ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // complaint.title.toString(),
                      complaint.title != null
                          ? complaint.title!.capitalize!
                          : "Title",
                      style: const TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          complaint.hostel!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        complaint.date == null
                            ? const SizedBox()
                            : Text(
                                DateFormat.yMMMd()
                                    .format(complaint.date!)
                                    .toString(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
