// import 'package:complaint_portal/common/theme/custom_colors.dart';
// import 'package:complaint_portal/common/utils/enums.dart';
// import 'package:complaint_portal/features/home/filter/filter_provider.dart';
// import 'package:complaint_portal/features/home/filter/filter_section.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/manage_users/filter/filter_provider.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';

// class FilterDialog extends ConsumerWidget {
//   const FilterDialog({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final UserModel? user = ref.watch(userProvider);
//     return ListTile(
//       title: Text(
//         // "Your Complaints",
//         user!.userType! == UserType.student
//             ? "Your Complaints"
//             : user.userType == UserType.admin
//                 ? "All Complaints"
//                 : user.userType == UserType.warden
//                     ? "Your Hostel Complaints"
//                     : "All Complaints",
//         style: Theme.of(context).textTheme.titleLarge!.copyWith(
//               fontWeight: FontWeight.w800,
//               fontSize: 25,
//               // color: const Color.fromARGB(255, 6, 56, 97).withOpacity(0.8)
//               //,
//               // color: Theme.of(context).brightness == Brightness.light
//               //     ? const Color.fromARGB(255, 6, 56, 97).withOpacity(0.8)
//               //     : const Color.fromARGB(255, 101, 185, 253).withOpacity(0.8),
//               color:
//                   ThemeColors.homePageFontColor[Theme.of(context).brightness],
//             ),
//       ),
//       trailing: IconButton(
//         icon: Icon(
//           Icons.filter_list_rounded,
//           // color: Theme.of(context).iconTheme.color,
//           color:
//               ref.watch(complaintFilterOptionsProvider)['status']!.isNotEmpty ||
//                       ref
//                           .watch(complaintFilterOptionsProvider)['category']!
//                           .isNotEmpty ||
//                       ref
//                           .watch(complaintFilterOptionsProvider)['hostel']!
//                           .isNotEmpty
//                   ? Theme.of(context).iconTheme.color!.withOpacity(0.5)
//                   : Theme.of(context).iconTheme.color,
//         ),
//         onPressed: () async {
//           return await Get.dialog(
//             StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//                 return AlertDialog(
//                   backgroundColor: ThemeColors.filterDialogBackgroundColor[
//                       Theme.of(context).brightness],
//                   title: Center(
//                     child: Text(
//                       "Filter Options",
//                       style: TextStyles(Theme.of(context).brightness)
//                           .filterHeaderTextStyle,
//                     ),
//                   ),
//                   content: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const FilterSection(
//                           headerText: 'Status',
//                           filtername: 'status',
//                         ),
//                         Visibility(
//                           visible: user.userType! == UserType.student ||
//                               user.userType == UserType.admin ||
//                               user.userType == UserType.warden,
//                           child: const FilterSection(
//                             headerText: 'Category',
//                             filtername: 'category',
//                           ),
//                         ),
//                         Visibility(
//                           visible: user.userType != UserType.student,
//                           child: const FilterSection(
//                             headerText: 'Hostel',
//                             filtername: 'hostel',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   actions: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ThemeColors
//                             .elevatedButtonColor[Theme.of(context).brightness],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: Text(
//                         "Clear",
//                         style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                               fontWeight: FontWeight.w900,
//                               fontSize: 20,
//                               color: ThemeColors.filterDoneButtonColor[
//                                   Theme.of(context).brightness],
//                             ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: ThemeColors
//                             .elevatedButtonColor[Theme.of(context).brightness],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: Text(
//                         "Done",
//                         style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                               fontWeight: FontWeight.w900,
//                               fontSize: 20,
//                               color: ThemeColors.filterDoneButtonColor[
//                                   Theme.of(context).brightness],
//                             ),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
