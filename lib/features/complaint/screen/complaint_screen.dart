// Display all detailds of a complaint

import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedItemProvider = StateProvider<String?>((ref) => null);

class ComplaintScreen extends ConsumerWidget {
  final String complaintId;
  const ComplaintScreen({
    super.key,
    required this.complaintId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          
          // title: const Text('Complaint Details'),
          // centerTitle: true,
          // backgroundColor: kPrimaryColor,
          ),
      body: Column(
        children: [
          Text('Complaint Id: $complaintId'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
