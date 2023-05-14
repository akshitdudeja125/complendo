import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/features/home/filter/filter_provider.dart';
import 'package:complaint_portal/features/home/filter/filter_section.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FilterDialog extends ConsumerStatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends ConsumerState<FilterDialog> {
  // DateTimeRange? _selectedDateRange;
  // This function will be triggered when the floating button is pressed
  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      //set the selected date range equal to the date range in the provider
      initialDateRange:
          ref.read(complaintFilterOptionsProvider)["selectedDateRange"],

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF8CE7F1),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(
                  primary: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 6, 56, 97).withOpacity(0.8)
                      : const Color.fromARGB(255, 6, 56, 97).withOpacity(0.8))),
          child: child!,
        );
      },
      firstDate: DateTime(2022, 1, 1),
      // lastDate: DateTime(2030, 12, 31),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      setState(() {
        // _selectedDateRange = result;
        ref.watch(complaintFilterOptionsProvider.notifier).state = {
          "status": ref.read(complaintFilterOptionsProvider)["status"],
          "category": ref.read(complaintFilterOptionsProvider)["category"],
          "hostel": ref.read(complaintFilterOptionsProvider)["hostel"],
          "selectedDateRange": result,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = ref.watch(userProvider);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text(
            // "Your Complaints",
            user!.userType! == UserType.student
                ? "Your Complaints"
                : user.userType == UserType.admin
                    ? "All Complaints"
                    : user.userType == UserType.warden
                        ? "Hostel Complaints"
                        : "All Complaints",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  // color: const Color.fromARGB(255, 6, 56, 97).withOpacity(0.8)
                  //,
                  // color: Theme.of(context).brightness == Brightness.light
                  //     ? const Color.fromARGB(255, 6, 56, 97).withOpacity(0.8)
                  //     : const Color.fromARGB(255, 101, 185, 253).withOpacity(0.8),
                  color: ThemeColors
                      .homePageFontColor[Theme.of(context).brightness],
                ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              if (ref.watch(
                      complaintFilterOptionsProvider)['selectedDateRange'] ==
                  null) {
                _show();
              } else {
                ref.watch(complaintFilterOptionsProvider.notifier).state = {
                  "status": ref.read(complaintFilterOptionsProvider)["status"],
                  "category":
                      ref.read(complaintFilterOptionsProvider)["category"],
                  "hostel": ref.read(complaintFilterOptionsProvider)["hostel"],
                  "selectedDateRange": null,
                };
              }
            },
            icon: ref.watch(
                        complaintFilterOptionsProvider)['selectedDateRange'] ==
                    null
                ? Icon(
                    Icons.date_range_rounded,
                    // color: Theme.of(context).iconTheme.color,
                    color: Theme.of(context).iconTheme.color!,
                  )
                : Icon(
                    FeatherIcons.x,
                    // color: Theme.of(context).iconTheme.color,
                    color: Theme.of(context).iconTheme.color,
                  ),
            // icon: Icon(
            //   Icons.date_range_rounded,
            //   // color: Theme.of(context).iconTheme.color,
            //   color:
            //       ref.watch(complaintFilterOptionsProvider)['startDate'] != null
            //           ? Theme.of(context).iconTheme.color!.withOpacity(0.5)
            //           : Theme.of(context).iconTheme.color,
            // ),
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list_rounded,
              // color: Theme.of(context).iconTheme.color,
              color: ref
                          .watch(complaintFilterOptionsProvider)['status']!
                          .isNotEmpty ||
                      ref
                          .watch(complaintFilterOptionsProvider)['category']!
                          .isNotEmpty ||
                      ref
                          .watch(complaintFilterOptionsProvider)['hostel']!
                          .isNotEmpty
                  ? Theme.of(context).iconTheme.color!.withOpacity(0.5)
                  : Theme.of(context).iconTheme.color,
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
                          children: [
                            //add a date section to container and add a date picker and with two dates 1 is start date and 2 is end date

                            // Container(
                            //   height: 50,
                            //   width: double.infinity,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     color: ThemeColors.filterDialogBackgroundColor[
                            //         Theme.of(context).brightness],
                            //     border: Border.all(
                            //         // color: ThemeColors.filterDialogBorderColor[
                            //         //     Theme.of(context).brightness],
                            //         ),
                            //   ),
                            // child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 10),
                            //       child: Text("Date",
                            //           style:
                            //               TextStyles(Theme.of(context).brightness)
                            //                   .filterHeaderTextStyle
                            //                   .copyWith(
                            //                     fontSize: 20,
                            //                   )),
                            //     ),
                            //   ],
                            // ),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            const FilterSection(
                              headerText: 'Status',
                              filtername: 'status',
                            ),
                            Visibility(
                              visible: user.userType! == UserType.student ||
                                  user.userType == UserType.admin ||
                                  user.userType == UserType.warden,
                              child: const FilterSection(
                                headerText: 'Category',
                                filtername: 'category',
                              ),
                            ),
                            Visibility(
                              visible: user.userType != UserType.student &&
                                  user.userType != UserType.warden,
                              child: const FilterSection(
                                headerText: 'Hostel',
                                filtername: 'hostel',
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                // Theme.of(context).brightness == Brightness.light
                                //     ? const Color.fromARGB(255, 6, 56, 97)
                                //         .withOpacity(0.8)
                                //     : Colors.grey.shade400,
                                ThemeColors.elevatedButtonColor[
                                    Theme.of(context).brightness],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            ref
                                .watch(complaintFilterOptionsProvider.notifier)
                                .state = {
                              'status': [],
                              'category': [],
                              'hostel': [],
                              'selectedDateRange': null,
                            };
                          },
                          child: Text(
                            "Clear",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  // color: Theme.of(context).brightness ==
                                  //         Brightness.light
                                  //     ? Colors.white
                                  //     : Colors.black,
                                  color: ThemeColors.filterDoneButtonColor[
                                      Theme.of(context).brightness],
                                ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                // Theme.of(context).brightness == Brightness.light
                                //     ? const Color.fromARGB(255, 6, 56, 97)
                                //         .withOpacity(0.8)
                                //     : Colors.grey.shade400,
                                ThemeColors.elevatedButtonColor[
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  // color: Theme.of(context).brightness ==
                                  //         Brightness.light
                                  //     ? Colors.white
                                  //     : Colors.black,
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
      ),
    );
  }
}
