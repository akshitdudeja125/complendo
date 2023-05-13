//return a class to return the above appbar
import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/manage_users/filter/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'filter/filter_section.dart';

class CustomAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      centerTitle: true,
      title: isSearch
          ? TextFormFieldItem(
              labelText: 'Search',
              controller: widget.searchController,
              onChanged: (value) {
                ref.read(userFilterOptionsProvider.notifier).state = {
                  "hostel": ref.read(userFilterOptionsProvider)["hostel"]!,
                  "usertype": ref.read(userFilterOptionsProvider)["usertype"]!,
                  "status": ref.read(userFilterOptionsProvider)["status"]!,
                  "search": value,
                };
              },
            )
          : Text(
              "Manage Users",
              style: TextStyles(Theme.of(context).brightness).appbarTextStyle,
            ),
      actions: [
        IconButton(
          icon: Icon(
            // Icons.search,
            isSearch ? FeatherIcons.x : FeatherIcons.search,
            color: ThemeColors.iconColor[Theme.of(context).brightness],
          ),
          onPressed: () {
            setState(() {
              isSearch = !isSearch;
              if (!isSearch) {
                ref.read(userFilterOptionsProvider.notifier).state = {
                  "hostel": ref.read(userFilterOptionsProvider)["hostel"]!,
                  "usertype": ref.read(userFilterOptionsProvider)["usertype"]!,
                  "status": ref.read(userFilterOptionsProvider)["status"]!,
                  "search": "",
                };
                widget.searchController.clear();
              }
            });
          },
        ),
        IconButton(
          icon: Icon(
            FeatherIcons.filter,
            // color: ThemeColors.iconColor[Theme.of(context).brightness],
            color: ref.read(userFilterOptionsProvider)["hostel"]!.isEmpty &&
                    ref.read(userFilterOptionsProvider)["usertype"]!.isEmpty &&
                    ref.read(userFilterOptionsProvider)["status"]!.isEmpty
                ? ThemeColors.iconColor[Theme.of(context).brightness]!
                    .withOpacity(0.5)
                : ThemeColors.iconColor[Theme.of(context).brightness]!
                    .withOpacity(1),
          ),
          onPressed: () async {
            return await Get.dialog(
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    backgroundColor: ThemeColors.filterDialogBackgroundColor[
                        Theme.of(context).brightness],
                    title: Center(
                      child: Text(
                        "Filter Options",
                        style: TextStyles(Theme.of(context).brightness)
                            .filterHeaderTextStyle,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: const [
                          FilterSection(
                            headerText: 'User Type',
                            filtername: 'usertype',
                          ),
                          FilterSection(
                            headerText: 'Hostel',
                            filtername: 'hostel',
                          ),
                          FilterSection(
                            headerText: 'Status',
                            filtername: 'status',
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.elevatedButtonColor[
                              Theme.of(context).brightness],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          ref.watch(userFilterOptionsProvider.notifier).state =
                              {
                            "hostel": [],
                            "usertype": [],
                            "status": [],
                            "search": "",
                          };
                        },
                        child: Text(
                          "Clear",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: ThemeColors.filterDoneButtonColor[
                                        Theme.of(context).brightness],
                                  ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.elevatedButtonColor[
                              Theme.of(context).brightness],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Done",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: ThemeColors.filterDoneButtonColor[
                                        Theme.of(context).brightness],
                                  ),
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
