import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_provider.dart';
import 'package:complaint_portal/features/complaint/widgets/complaint_card.dart';
import 'package:complaint_portal/features/home/filter/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/complaint_model.dart';

class FilteredComplaints extends StatelessWidget {
  const FilteredComplaints({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          final filterOptions = ref.watch(complaintFilterOptionsProvider);
          final user = ref.watch(userProvider);
          final List<Complaint> complaints = ref.watch(complaintListProvider);

          final filteredComplaints = complaints.where((complaint) {
            return filterOptions['status']!.contains(complaint.status!.value) ||
                filterOptions['status']!.isEmpty;
          }).where((complaint) {
            if (userTypeToComplaintTypeMap[user.userType!] != null) {
              return complaint.category != null &&
                  complaint.category! ==
                      userTypeToComplaintTypeMap[user.userType!];
            }
            return filterOptions['category']!.contains(complaint.category) ||
                filterOptions['category']!.isEmpty;
          }).where((complaint) {
            return filterOptions['hostel']!.contains(complaint.hostel!.value) ||
                filterOptions['hostel']!.isEmpty;
          }).where((complaint) {
            if (user.userType!.value == 'warden') {
              return complaint.hostel!.value == user.hostel!.value;
            }
            return true;
          }).where((complaint) {
            if (user.userType!.value == 'student') {
              return complaint.uid == user.id ||
                  (complaint.hostel == user.hostel &&
                      complaint.complaintType == "Common");
            }
            return true;
          }).where((complaint) {
            if (filterOptions['selectedDateRange'] == null) {
              return true;
            }
            // print(filterOptions['selectedDateRange']!.start);
            // print(filterOptions['selectedDateRange']!.end);
            print({
              'complaint.date': complaint.date,
              'filterOptions': filterOptions['selectedDateRange'],
              'same as start': complaint.date!
                  .isAtSameMomentAs(filterOptions['selectedDateRange']!.start),
              'same as end': complaint.date!
                  .isAtSameMomentAs(filterOptions['selectedDateRange']!.end),
              'between': complaint.date!
                      .isAfter(filterOptions['selectedDateRange']!.start) &&
                  complaint.date!
                      .isBefore(filterOptions['selectedDateRange']!.end),
            });
            return (complaint.date!
                    .isAfter(filterOptions['selectedDateRange']!.start) &&
                complaint.date!.isBefore(filterOptions['selectedDateRange']!
                    .end
                    .add(const Duration(days: 1))));
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
    );
  }
}
