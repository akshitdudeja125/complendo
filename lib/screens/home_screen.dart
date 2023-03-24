import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/widgets/complaint_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final List<String> _segments;
  late final ValueNotifier<int> _selectedSegmentIndex;

  @override
  void initState() {
    super.initState();
    _segments = ["Open", "All", "Closed"];
    _selectedSegmentIndex = ValueNotifier<int>(0);
  }

  Stream<QuerySnapshot> _getComplaintStream(String segment) {
    if (segment == "Open") {
      return FirebaseFirestore.instance
          .collection('complaints')
          .where('status', isEqualTo: "Pending")
          .snapshots();
    } else if (segment == "Closed") {
      return FirebaseFirestore.instance
          .collection('complaints')
          .where('uid', isEqualTo: "Closed")
          .snapshots();
    } else {
      return FirebaseFirestore.instance.collection('complaints').snapshots();
    }
  }

  @override
  void dispose() {
    _selectedSegmentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            ValueListenableBuilder<int>(
              valueListenable: _selectedSegmentIndex,
              builder: (context, selectedIndex, _) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CupertinoSlidingSegmentedControl(
                    children: {
                      for (var e in _segments)
                        _segments.indexOf(e): Text(
                          e,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                    },
                    groupValue: selectedIndex,
                    onValueChanged: (value) {
                      setState(() {
                        _selectedSegmentIndex.value = value!;
                      });
                    },
                  ),
                );
              },
            ),
            StreamBuilder(
              stream:
                  _getComplaintStream(_segments[_selectedSegmentIndex.value]),
              builder:
                  (context, AsyncSnapshot<QuerySnapshot> complaintSnapshot) {
                if (complaintSnapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (complaintSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final complaints = complaintSnapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      return ComplaintCard(
                        complaint: complaints[index],
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
