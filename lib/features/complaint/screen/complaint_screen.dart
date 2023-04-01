// Display all detailds of a complaint

import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final selectedItemProvider = StateProvider<String?>((ref) => null);

class ComplaintScreen extends ConsumerWidget {
  // final String complaintId;
  final Complaint complaint;
  const ComplaintScreen({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(


          ),
      body: Column(
        children: [
          // ignore: prefer_const_constructors
          Text(
            "Complaint Details",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Title: ${complaint.title}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "cid: ${complaint.cid}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Category: ${complaint.category}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Description: ${complaint.description}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Status: ${complaint.status}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Date: ${DateFormat.yMMMd().format(complaint.date!)}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Time: ${DateFormat.jm().format(complaint.date!)}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
