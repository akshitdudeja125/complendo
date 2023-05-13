import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/features/auth/repository/user_repository.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

void changeUserRoleDialog({
  required UserModel user,
  required WidgetRef ref,
}) {
  Get.dialog(
    AlertDialog(
      title: const Text("Change User Role"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //List of Radio Buttons with roles in UserTyoe,get

          for (var role in UserType.values)
            RadioListTile(
              value: role,
              groupValue: user.userType,
              onChanged: (value) {
                ref.watch(userRepositoryProvider).updateUserField(
                      user.id,
                      "userType",
                      value.toString(),
                    );
                Get.back();
                Get.back();
              },
              title: Text(role.toString().capitalizeFirst!),
            ),
        ],
      ),
    ),
  );
}
