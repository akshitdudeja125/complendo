import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({
    Key? key,
    required this.complaint,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> complaint;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              complaint['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  complaint['category'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateFormat.yMMMd()
                      .format(complaint['date'].toDate())
                      .toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (complaint['status'] != "Pending")
              Text(
                complaint['status'],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// class ComplaintCard extends StatelessWidget {
//   const ComplaintCard({
//     super.key,
//     required this.complaint,
//   });
//   final QueryDocumentSnapshot<Object?> complaint;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(complaint['title']),
//         subtitle: Text(complaint['description']),
//         trailing: Text(complaint['status']),
//       ),
//     );
//   }
// }

