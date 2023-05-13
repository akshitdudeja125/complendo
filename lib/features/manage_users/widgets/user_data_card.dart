import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/features/auth/repository/user_repository.dart';
import 'package:complaint_portal/features/manage_users/user_details_screen.dart';
import 'package:complaint_portal/features/manage_users/widgets/change_user_type_dialog.dart';
import 'package:complaint_portal/features/manage_users/widgets/custom_popup_menu.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class UserDetailsCard extends StatelessWidget {
  final UserModel user;
  const UserDetailsCard({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: GestureDetector(
          onTap: () {
            Get.to(
              () => UserDetailsScreen(
                user: user,
              ),
            );
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => PhotoView(
                            loadingBuilder: (context, event) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            imageProvider: NetworkImage(user.photoURL!),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2,

                            heroAttributes:
                                const PhotoViewHeroAttributes(tag: "someTag"),
                            // Back button?
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                    child: Text("Error Loading Image")),
                          ),
                        );
                      },
                      child: user.photoURL == null
                          ? const Icon(Icons.person,
                              size: 50, color: Colors.black)
                          : Image.network(
                              user.photoURL!,
                              height: 50,
                              width: 50,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      user.userType.toString().capitalizeFirst!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  return PopupMenuButton(
                    tooltip: "Manage User",
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    // color: Colors.grey[100],
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[100]
                        : Colors.grey[800],
                    clipBehavior: Clip.antiAlias,
                    constraints: const BoxConstraints(
                      minWidth: 100,
                    ),
                    itemBuilder: (context) {
                      return [
                        customPopUpMenuItem(
                          context: context,
                          title: "Change User Role",
                          icon: Icons.check_circle_outline,
                          onTap: () {
                            changeUserRoleDialog(
                              user: user,
                              ref: ref,
                            );
                          },
                        ),
                        if (user.userType != UserType.admin &&
                            user.userType != UserType.warden)
                          customPopUpMenuItem(
                            context: context,
                            title: "Delete User",
                            icon: Icons.delete,
                            onTap: () {
                              ref.watch(userRepositoryProvider).deleteUser(
                                    user.id,
                                  );
                            },
                          ),
                        customPopUpMenuItem(
                          context: context,
                          title: user.blocked ?? false
                              ? "Unblock User"
                              : "Block User",
                          icon: Icons.block_sharp,
                          onTap: () {
                            ref.watch(userRepositoryProvider).changeBlockStatus(
                                  user.id,
                                  user.blocked ?? false,
                                );
                          },
                        ),
                      ];
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
