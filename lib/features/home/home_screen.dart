import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
import 'package:complaint_portal/features/complaint/widgets/complaint_card.dart';
import 'package:complaint_portal/features/home/filter/filter_dialog.dart';
import 'package:complaint_portal/features/home/filter/filter_provider.dart';
import 'package:complaint_portal/features/profile/profile.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}


class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(filteredOptionsProvider.notifier).state = {
        "status": [],
        "category": [],
        "hostel": [],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("homePage"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                final user = ref.watch(userProvider);
                return ListTile(
                  title: Text(
                    "Welcome ${user.name.split(" ")[0].capitalizeFirst} ",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Get.to(
                        () => const StudentProfile(),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              const FilterDialog(),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, _) {
                    final filterOptions = ref.watch(filteredOptionsProvider);
                    final List<Complaint> complaints =
                        ref.watch(myComplaintListProvider);
                    return ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (BuildContext context, int index) {
                        final complaint = complaints[index];
                        if (filterOptions['status']!
                                .contains(complaint.status) ||
                            filterOptions['status']!.isEmpty &&
                                (filterOptions['category']!
                                        .contains(complaint.category) ||
                                    filterOptions['category']!.isEmpty) &&
                                (filterOptions['hostel']!
                                        .contains(complaint.hostel) ||
                                    filterOptions['hostel']!.isEmpty)) {
                          return ComplaintCard(
                            complaint: complaint,
                            user: ref.watch(userProvider),
                          );
                        }
                        return Container();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// import 'package:complaint_portal/common/utils/constants.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
// import 'package:complaint_portal/features/complaint/widgets/complaint_card.dart';
// import 'package:complaint_portal/features/profile/profile.dart';
// import 'package:complaint_portal/models/complaint_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';

// import '../../common/services/ads/ad_helper.dart';

// final selectedSegmentIndexProvider =
//     StateNotifierProvider.autoDispose((ref) => SelectedSegmentIndexNotifier());

// class SelectedSegmentIndexNotifier extends StateNotifier<int> {
//   SelectedSegmentIndexNotifier() : super(0);

//   void setSelectedSegmentIndex(int index) {
//     state = index;
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// final filteredOptionsProvider =
//     StateNotifierProvider.autoDispose((ref) => FilterOptionsNotifier());

// class FilterOptionsNotifier extends StateNotifier<List<String>> {
//   FilterOptionsNotifier() : super([]);

//   void setFilterOptions(List<String> options) {
//     state = options;
//   }

//   //setFilterOptions

//   //get List
//   List<String> getFilterOptions() {
//     return state;
//   }

//   bool contains(String option) {
//     return state.contains(option);
//   }

//   //update list
//   void updateFilterOptions(String option) {
//     if (state.contains(option)) {
//       state.remove(option);
//     } else {
//       state.add(option);
//     }
//   }
//   //add to list
// }

// class _HomePageState extends State<HomePage> {
//   // var _isFilterOpen = false;
//   // final segments = [
//   //   "Pending",
//   //   "Resolved",
//   //   "Rejected",
//   //   "All",
//   // ];

//   // var _selectedFilterOptions = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: const Key("homePage"),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               Consumer(builder: (BuildContext context, WidgetRef ref, _) {
//                 final user = ref.watch(userProvider);
//                 return ListTile(
//                   title: Text(
//                     "Welcome ${user.name.split(" ")[0].capitalizeFirst} ",
//                     style: const TextStyle(
//                       fontSize: 23,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(FeatherIcons.moreVertical),
//                     onPressed: () {
//                       //open dialog for more options
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text("Filter"),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 ListTile(
//                                   title: const Text("Pending"),
//                                   onTap: () {
//                                     // ref
//                                     //     .read(
//                                     //         selectedSegmentIndexProvider)
//                                     //     .setSelectedSegmentIndex(0);
//                                     Get.back();
//                                   },
//                                   trailing: Checkbox(
//                                     value: true,
//                                     onChanged: (value) {},
//                                   ),
//                                 ),
//                                 // ListTile(
//                                 //   title: const Text("Filter"),
//                                 //   onTap: () {
//                                 //     //show a filter dialog with options to select
//                                 //     Get.back();
//                                 //     showDialog(
//                                 //       context: context,
//                                 //       builder: (context) {
//                                 //         return AlertDialog(
//                                 //           title: const Text("Filter"),
//                                 //           content: Column(
//                                 //             mainAxisSize: MainAxisSize.min,
//                                 //             children: [
//                                 //               ListTile(
//                                 //                 title: const Text("Open"),
//                                 //                 onTap: () {
//                                 //                   // ref
//                                 //                   //     .read(
//                                 //                   //         selectedSegmentIndexProvider)
//                                 //                   //     .setSelectedSegmentIndex(0);
//                                 //                   Get.back();
//                                 //                 },
//                                 //                 trailing: Checkbox(
//                                 //                   value: true,
//                                 //                   onChanged: (value) {},
//                                 //                 ),
//                                 //               ),
//                                 //               ListTile(
//                                 //                 title: const Text("All"),
//                                 //                 onTap: () {
//                                 //                   // ref
//                                 //                   //     .read(
//                                 //                   //         selectedSegmentIndexProvider)
//                                 //                   //     .setSelectedSegmentIndex(1);
//                                 //                   Get.back();
//                                 //                 },
//                                 //                 trailing: Checkbox(
//                                 //                   value: true,
//                                 //                   onChanged: (value) {},
//                                 //                 ),
//                                 //               ),
//                                 //               ListTile(
//                                 //                 title: const Text("Resolved"),
//                                 //                 onTap: () {
//                                 //                   // ref
//                                 //                   //     .read(
//                                 //                   //         selectedSegmentIndexProvider)
//                                 //                   //     .setSelectedSegmentIndex(2);
//                                 //                   Get.back();
//                                 //                 },
//                                 //                 //create a trailing checkbox
//                                 //                 trailing: Checkbox(
//                                 //                   value: true,
//                                 //                   onChanged: (value) {},
//                                 //                 ),
//                                 //               ),
//                                 //             ],
//                                 //           ),
//                                 //         );
//                                 //       },
//                                 //     );
//                                 //   },
//                                 // ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),

//                   // trailing: InkWell(
//                   //     onTap: () {
//                   //       Get.to(
//                   //         () => const StudentProfile(),
//                   //       );
//                   //     },
//                   // child: FeatherIcons()
//                   // child:IconButton(

//                   // )
//                   // child: CircleAvatar(
//                   //   radius: 19,
//                   //   backgroundImage: NetworkImage(user.photoURL!),
//                   // ),
//                   // ),
//                 );
//               }),
//               const SizedBox(height: 10),
//               // const ListTile(
//               //   title: Text(
//               //     "Complaints :",
//               //     style: TextStyle(
//               //       fontSize: 20,
//               //       fontWeight: FontWeight.bold,
//               //     ),
//               //   ),
//               // ),
//               const SizedBox(height: 10),
//               // Consumer(builder: (BuildContext context, WidgetRef ref, _) {
//               //   final selectedSegmentIndex =
//               //       ref.watch(selectedSegmentIndexProvider) as int;

//               //   return SizedBox(
//               //     width: MediaQuery.of(context).size.width * 0.8,
//               //     child: CupertinoSlidingSegmentedControl(
//               //       children: {
//               //         for (var e in segments)
//               //           segments.indexOf(e): Text(
//               //             e,
//               //             style: Theme.of(context).textTheme.titleSmall,
//               //           )
//               //       },
//               //       groupValue: selectedSegmentIndex,
//               //       onValueChanged: (value) {
//               //         ref
//               //             .read(selectedSegmentIndexProvider.notifier)
//               //             .setSelectedSegmentIndex(value as int);
//               //       },
//               //     ),
//               //   );
//               // }),
//               //create a grey area which can be opened closed to selected filter options
//               ListTile(
//                 title: const Text(
//                   "Filter",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 trailing: IconButton(
//                   icon: const Icon(FeatherIcons.filter),
//                   onPressed: () async {
//                     return await showDialog(
//                         context: context,
//                         builder: (context) {
//                           bool isChecked = false;
//                           var _textEditingController = TextEditingController();
//                           var choice = false;
//                           return StatefulBuilder(builder: (context, setState) {
//                             return AlertDialog(
//                               content: Form(
//                                   // key: _formKey,
//                                   child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   TextFormField(
//                                     // controller: _textEditingController,
//                                     // validator: (value) {
//                                     //   return value.isNotEmpty
//                                     //       ? null
//                                     //       : "Enter any text";
//                                     // },
//                                     decoration: InputDecoration(
//                                         hintText: "Please Enter Text"),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Choice Box"),
//                                       Checkbox(
//                                           value: isChecked,
//                                           onChanged: (checked) {
//                                             setState(() {
//                                               // isChecked = checked;
//                                             });
//                                           })
//                                     ],
//                                   )
//                                 ],
//                               )),
//                               title: Text('Stateful Dialog'),
//                               actions: <Widget>[
//                                 InkWell(
//                                   child: Text('OK   '),
//                                   onTap: () {
//                                     // if (_formKey.currentState.validate()) {
//                                     // Do something like updating SharedPreferences or User Settings etc.
//                                     Navigator.of(context).pop();
//                                     // }
//                                   },
//                                 ),
//                               ],
//                             );
//                           });
//                         });
//                     // setState(() {
//                     //   if (_isFilterOpen) {
//                     //     _selectedFilterOptions.clear();
//                     //   }
//                     //   _isFilterOpen = !_isFilterOpen;

//                     // }
//                     // );
//                     // show dialog for filter options
//                     // var _selectedFilterOptions = [];
//                     // Get.dialog(
//                     //   Consumer(builder: (context, ref, _) {
//                     //     // final filteredOptions =
//                     //     //     ref.watch(filteredOptionsProvider) as List<String>;
//                     //     // print("filteredOptions is $filteredOptions");
//                     //     return AlertDialog(
//                     //       title: const Text("Filter"),
//                     //       content: StatefulBuilder(builder:
//                     //           (BuildContext context, StateSetter setState) {
//                     //         var _selectedFilterOptions = [];
//                     //         final filterOptions = [
//                     //           "Open",
//                     //           "All",
//                     //           "Resolved",
//                     //         ];
//                     //         return Wrap(
//                     //           children: [
//                     //             for (var e in filterOptions)
//                     //               Padding(
//                     //                 padding: const EdgeInsets.symmetric(
//                     //                     horizontal: 8.0),
//                     //                 child: FilterChip(
//                     //                   selectedColor: Colors.blue,
//                     //                   label: Text(e),
//                     //                   selected:
//                     //                       _selectedFilterOptions.contains(e),
//                     //                   onSelected: (value) {
//                     //                     setState(() {
//                     //                       if (value) {
//                     //                         _selectedFilterOptions.add(e);
//                     //                       } else {
//                     //                         _selectedFilterOptions.remove(e);
//                     //                       }
//                     //                     });
//                     //                   },
//                     //                 ),
//                     //               ),
//                     //           ],
//                     //         );
//                     //       }),
//                     //     );
//                     //   }),
//                     // );
//                   },
//                 ),
//               ),
//               // if (_isFilterOpen)
//               //   Wrap(
//               //     children: [
//               //       for (var e in filterOptions)
//               //         Padding(
//               //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               //           child: FilterChip(
//               //             selectedColor: Colors.blue,
//               //             label: Text(e),
//               //             selected: _selectedFilterOptions.contains(e),
//               //             onSelected: (value) {
//               //               setState(() {
//               //                 if (value) {
//               //                   _selectedFilterOptions.add(e);
//               //                 } else {
//               //                   _selectedFilterOptions.remove(e);
//               //                 }
//               //               });
//               //             },
//               //           ),
//               //         ),
//               //     ],
//               //   ),
//               const SizedBox(height: 10),
//               // Consumer(
//               //   builder: (BuildContext context, WidgetRef ref, _) {
//               //     final user = ref.watch(userProvider);
//               //     final selectedSegmentIndex =
//               //         ref.watch(selectedSegmentIndexProvider) as int;
//               //     final complaintList = ref.watch(complaintListProvider(
//               //         _getSegmentName(selectedSegmentIndex)));
//               //     return Expanded(
//               //       child: Column(
//               //         children: [
//               //           Expanded(
//               //             child: ListView.builder(
//               //               itemCount: complaintList.length,
//               //               itemBuilder: (context, index) {
//               //                 return Column(
//               //                   children: [
//               //                     ComplaintCard(
//               //                       user: user,
//               //                       complaint: complaintList[index],
//               //                     ),
//               //                     SizedBox(
//               //                       height: MediaQuery.of(context).size.height *
//               //                           0.01,
//               //                     ),
//               //                   ],
//               //                 );
//               //               },
//               //             ),
//               //           ),
//               //           SizedBox(
//               //             height: MediaQuery.of(context).size.height * 0.01,
//               //           ),
//               //         ],
//               //       ),
//               //     );
//               //   },
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// String _getSegmentName(int index) {
//   switch (index) {
//     case 0:
//       return "Pending";
//     case 1:
//       return "Resolved";
//     case 2:
//       return "Rejected";
//     case 3:
//       return "All";
//     default:
//       return "";
//   }
// }
