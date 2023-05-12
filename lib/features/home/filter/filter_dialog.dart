import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/features/home/filter/filter_provider.dart';
import 'package:complaint_portal/features/home/filter/filter_section.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FilterDialog extends ConsumerWidget {
  const FilterDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel? user = ref.watch(userProvider);
    return ListTile(
      title: Text(
        "Complaints:",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w300,
            ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.filter_list_rounded,
          // color: Theme.of(context).iconTheme.color,
          color: ref.watch(filteredOptionsProvider)['status']!.isNotEmpty ||
                  ref.watch(filteredOptionsProvider)['category']!.isNotEmpty ||
                  ref.watch(filteredOptionsProvider)['hostel']!.isNotEmpty
              ? Theme.of(context).iconTheme.color!.withOpacity(0.5)
              : Theme.of(context).iconTheme.color,
        ),
        onPressed: () async {
          return await Get.dialog(
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text("Filter Options"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        const FilterSection(
                          headerText: 'Status',
                          filtername: 'status',
                        ),
                        Visibility(
                          visible: user!.userType! == UserType.student ||
                              user.userType == UserType.admin ||
                              user.userType == UserType.warden,
                          child: const FilterSection(
                            headerText: 'Category',
                            filtername: 'category',
                          ),
                        ),
                        Visibility(
                          visible: user.userType != UserType.student,
                          child: const FilterSection(
                            headerText: 'Hostel',
                            filtername: 'hostel',
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Done"),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
