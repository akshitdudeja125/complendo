// Display all detailds of a complaint

import 'package:complaint_portal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        title: const Text('Complaint Details'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Text('Complaint Id: $complaintId'),
        ],
      ),
    );
  }
}
