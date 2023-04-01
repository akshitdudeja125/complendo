import 'package:complaint_portal/features/complaint/screen/provider/complaint_provider.dart';
import 'package:complaint_portal/common/widgets/complaint_card.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSegmentIndexProvider =
    StateNotifierProvider.autoDispose((ref) => SelectedSegmentIndexNotifier());

class SelectedSegmentIndexNotifier extends StateNotifier<int> {
  SelectedSegmentIndexNotifier() : super(0);

  void setSelectedSegmentIndex(int index) {
    state = index;
  }
}

class HomePage extends StatelessWidget {
  // get complaintStreamProvider from ComplaintRepository
  // final Map<String, dynamic> userData;
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final segments = [
      "Open",
      "All",
      "Resolved",
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
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
          Consumer(builder: (BuildContext context, WidgetRef ref, _) {
            final selectedSegmentIndex =
                ref.watch(selectedSegmentIndexProvider) as int;
            final complaintSnapshot = ref.watch(
                complaintStreamProvider(_getSegmentName(selectedSegmentIndex)));
            return complaintSnapshot.when(
              data: (data) {
                final complaintList = data.docs
                    .map((e) => Complaint.fromObject(e.data()))
                    .toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: complaintList.length,
                    itemBuilder: (context, index) {
                      return ComplaintCard(
                        user: user,
                        complaint: complaintList[index],
                      );
                    },
                  ),
                );
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
