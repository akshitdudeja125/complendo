import 'package:flutter/material.dart';

deleteComplaintDialog(context) async {
  final result = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Complaint'),
      content: const Text('Are you sure you want to delete this complaint?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );
  return result;
}