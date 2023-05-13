//create a new function for this
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void markAsResolvedDialog({
  required Complaint complaint,
  required WidgetRef ref,
  UserModel? user,
}) {
  Get.dialog(
    AlertDialog(
      title: const Text('Mark as Resolved'),
      content: const Text(
          'Are you sure you want to mark this complaint as resolved?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Get.dialog(
              AlertDialog(
                title: const Text('Add Comment'),
                content: const Text('Do you want to add a comment?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(complaintRepositoryProvider)
                          .changeComplaintStatus(
                            complaint: complaint,
                            ref: ref,
                            resolvedBy: user?.name,
                            to: 'resolved',
                          );
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      final textController = TextEditingController();
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Add Comment'),
                          content: TextField(
                            controller: textController,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                                ref
                                    .read(complaintRepositoryProvider)
                                    .changeComplaintStatus(
                                      complaint: complaint,
                                      ref: ref,
                                      comment: textController.text,
                                      resolvedBy: user?.name,
                                      to: 'resolved',
                                    );
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

void markAsPendingDialog({
  required Complaint complaint,
  required WidgetRef ref,
}) {
  Get.dialog(
    AlertDialog(
      title: const Text("Mark as Pending"),
      content: const Text(
          "Are you sure you want to mark this complaint as pending?"),
      actions: [
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text("Yes"),
          onPressed: () {
            Get.back();
            ref.read(complaintRepositoryProvider).changeComplaintStatus(
                  complaint: complaint,
                  ref: ref,
                  to: 'pending',
                );
          },
        ),
      ],
    ),
  );
}

void markAsRejectedDialog({
  required Complaint complaint,
  required WidgetRef ref,
}) {
  Get.dialog(
    AlertDialog(
      title: const Text('Mark as Rejected'),
      content: const Text(
          'Are you sure you want to mark this complaint as rejected?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Get.dialog(
              AlertDialog(
                title: const Text('Add Comment'),
                content: const Text('Do you want to add a comment?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(complaintRepositoryProvider)
                          .changeComplaintStatus(
                            complaint: complaint,
                            ref: ref,
                            to: 'rejected',
                          );
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      final textController = TextEditingController();
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Add Comment'),
                          content: TextField(
                            controller: textController,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                                ref
                                    .read(complaintRepositoryProvider)
                                    .changeComplaintStatus(
                                      complaint: complaint,
                                      ref: ref,
                                      comment: textController.text,
                                      to: 'rejected',
                                    );
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

void changeCommentDialog({
  required Complaint complaint,
  required WidgetRef ref,
  required String status,
}) {
  final textController = TextEditingController();
  Get.dialog(
    AlertDialog(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,
      title: const Text('Edit Complaint'),
      content: TextFormFieldItem(
        labelText: 'Comment',
        controller: textController,
        textColor: Theme.of(Get.context!).colorScheme.onBackground,
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Theme.of(Get.context!).brightness == Brightness.light
                    ? Colors.grey.shade800
                    : Theme.of(Get.context!).colorScheme.primary,
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(Get.context!).colorScheme.onPrimary,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Theme.of(Get.context!).brightness == Brightness.light
                    ? Colors.grey.shade800
                    : Theme.of(Get.context!).colorScheme.primary,
          ),
          onPressed: () {
            Get.back();
            ref.read(complaintRepositoryProvider).changeComplaintStatus(
                  complaint: complaint,
                  ref: ref,
                  comment: textController.text,
                  to: status,
                );
          },
          child: Text(
            'Submit',
            style: TextStyle(
              color: Theme.of(Get.context!).colorScheme.onPrimary,
            ),
          ),
        ),
        // ),
      ],
    ),
  );
}
