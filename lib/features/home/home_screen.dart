import 'package:complaint_portal/features/complaint/screen/provider/complaint_provider.dart';
import 'package:complaint_portal/common/widgets/complaint_card.dart';
import 'package:complaint_portal/features/profile/student_profile.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import "package:filter_list/filter_list.dart";

final selectedSegmentIndexProvider =
    StateNotifierProvider.autoDispose((ref) => SelectedSegmentIndexNotifier());

class SelectedSegmentIndexNotifier extends StateNotifier<int> {
  SelectedSegmentIndexNotifier() : super(0);

  void setSelectedSegmentIndex(int index) {
    state = index;
  }
}

class HomePage extends StatefulWidget {
  // get complaintStreamProvider from ComplaintRepository
  // final Map<String, dynamic> userData;
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final segments = [
      "Open",
      "All",
      "Resolved",
    ];
    return Scaffold(
      key: const Key("homePage"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Welcome ${widget.user.name.split(" ")[0].capitalizeFirst} ",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    Get.to(
                      () => StudentProfile(
                        user: widget.user,
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 19,
                    backgroundImage: NetworkImage(widget.user.photoURL!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                title: Text(
                  "Complaints :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                final selectedSegmentIndex =
                    ref.watch(selectedSegmentIndexProvider) as int;

                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CupertinoSlidingSegmentedControl(
                    children: {
                      for (var e in segments)
                        segments.indexOf(e): Text(
                          e,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                    },
                    groupValue: selectedSegmentIndex,
                    onValueChanged: (value) {
                      ref
                          .read(selectedSegmentIndexProvider.notifier)
                          .setSelectedSegmentIndex(value as int);
                    },
                  ),
                );
              }),
              const SizedBox(height: 10),
              Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                final selectedSegmentIndex =
                    ref.watch(selectedSegmentIndexProvider) as int;
                final complaintSnapshot = ref.watch(complaintStreamProvider(
                    _getSegmentName(selectedSegmentIndex)));
                return complaintSnapshot.when(
                  data: (data) {
                    final complaintList = data.docs
                        .map((e) => Complaint.fromObject(e.data()))
                        .toList();

                    List<Complaint> _filteredComplaints = complaintList;

                    // display complaints with filter option for complaint type and status and date

                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: complaintList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ComplaintCard(
                                      user: widget.user,
                                      complaint: _filteredComplaints[index],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     List<String> _filterList = [
                          //       "Complaint Type",
                          //       "Status",
                          //       "Date"
                          //     ];
                          //     List<String> _selectedFilterList = [];
                          //     await FilterListDialog.display<String>(
                          //       context,
                          //       listData: _filterList,
                          //       selectedListData: _selectedFilterList,
                          //       height: 480,
                          //       headlineText: "Filter",
                          //       choiceChipLabel: (item) {
                          //         return item;
                          //       },
                          //       validateSelectedItem: (list, val) {
                          //         return list!.contains(val);
                          //       },
                          //       onItemSearch: (list, text) {
                          //         return false;
                          //       },
                          //       onApplyButtonClick: (list) {
                          //         if (list != null) {
                          //           _selectedFilterList = List.from(list);
                          //         }
                          //         Navigator.pop(context);
                          //       },
                          //     );
                          //     setState(() {});
                          //   },
                          //   child: const Text("Filter"),
                          // ),
                        ],
                      ),
                    );

                    // return Expanded(
                    //   child: ListView.builder(
                    //     itemCount: complaintList.length,
                    //     itemBuilder: (context, index) {
                    //       return Column(
                    //         children: [
                    //           ComplaintCard(
                    //             user: widget.user,
                    //             complaint: _filteredComplaints[index],
                    //           ),
                    //           SizedBox(
                    //             height: MediaQuery.of(context).size.height * 0.01,
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) {
                    return Text('Something went wron Error:$error');
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

String _getSegmentName(int index) {
  switch (index) {
    case 0:
      return "Open";
    case 1:
      return "All";
    case 2:
      return "Closed";
    default:
      return "";
  }
}
