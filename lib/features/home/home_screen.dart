import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';
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
      ref.read(complaintFilterOptionsProvider.notifier).state = {
        "status": [],
        "category": [],
        "hostel": [],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      //p
      child: Scaffold(
        key: const Key("homePage"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                  final user = ref.watch(userProvider);
                  return ListTile(
                    // title: Text(
                    //   "Welcome ${user.name.split(" ")[0].capitalizeFirst} ",
                    //   style: const TextStyle(
                    //     fontSize: 23,
                    //     fontWeight: FontWeight.w900,
                    //   ),
                    // ),
                    title: Text(
                      "Complendo ",
                      style: TextStyle(
                        fontSize: 32,
                        // color: Color.fromARGB(255, 6, 56, 97),
                        // color: Theme.of(context).brightness == Brightness.light
                        //     ? const Color.fromARGB(255, 6, 56, 97)
                        //         .withOpacity(0.8)
                        //     : const Color.fromARGB(255, 101, 185, 253)
                        //         .withOpacity(0.8),
                        color: ThemeColors
                            .homePageFontColor[Theme.of(context).brightness],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // subtitle: Text(
                    //   " Hi, ${user.name.split(" ")[0].capitalizeFirst} ",
                    //   style: const TextStyle(
                    //     fontSize: 23,
                    //     color: Color.fromARGB(255, 6, 56, 97),
                    //     fontWeight: FontWeight.w900,
                    //   ),
                    // ),
                    // displau hi small and name bold
                    subtitle: Text.rich(
                      TextSpan(
                        text: " Hi, ",
                        style: TextStyle(
                          fontSize: 23,
                          // color: Color.fromARGB(255, 6, 56, 97),
                          // color:
                          //     Theme.of(context).brightness == Brightness.light
                          //         ? const Color.fromARGB(255, 6, 56, 97)
                          //             .withOpacity(0.8)
                          //         : const Color.fromARGB(255, 101, 185, 253)
                          //             .withOpacity(0.8),
                          color: ThemeColors
                              .homePageFontColor[Theme.of(context).brightness],
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: "${user.name.split(" ")[0].capitalizeFirst}",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: ThemeColors.homePageFontColor[
                                  Theme.of(context).brightness],
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        Get.to(
                          () => const Profile(),
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
                      final filterOptions =
                          ref.watch(complaintFilterOptionsProvider);
                      final user = ref.watch(userProvider);
                      final List<Complaint> complaints =
                          ref.watch(complaintListProvider);

                      final filteredComplaints = complaints.where((complaint) {
                        return filterOptions['status']!
                                .contains(complaint.status!.value) ||
                            filterOptions['status']!.isEmpty;
                      }).where((complaint) {
                        if (userTypeToComplaintTypeMap[user.userType!] !=
                            null) {
                          return complaint.category != null &&
                              complaint.category! ==
                                  userTypeToComplaintTypeMap[user.userType!];
                        }
                        return filterOptions['category']!
                                .contains(complaint.category) ||
                            filterOptions['category']!.isEmpty;
                      }).where((complaint) {
                        return filterOptions['hostel']!
                                .contains(complaint.hostel!.value) ||
                            filterOptions['hostel']!.isEmpty;
                      }).where((complaint) {
                        if (user.userType!.value == 'warden') {
                          return complaint.hostel!.value == user.hostel!.value;
                        }
                        return true;
                      }).where((complaint) {
                        if (user.userType!.value == 'student') {
                          return complaint.uid == user.id;
                        }
                        return true;
                      }).toList();
                      filteredComplaints.sort((a, b) {
                        return b.date!.compareTo(a.date!);
                      });
                      if (filteredComplaints.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Complaints",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: filteredComplaints.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (filteredComplaints.isEmpty) {
                            return const Center(
                              child: Text(
                                "No Complaints",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          return ComplaintCard(
                            complaint: filteredComplaints[index],
                            user: ref.watch(userProvider),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
