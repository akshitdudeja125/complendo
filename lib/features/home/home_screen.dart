import 'package:complaint_portal/features/home/display_filtered_complaints.dart';
import 'package:complaint_portal/features/home/filter/filter_dialog.dart';
import 'package:complaint_portal/features/home/filter/filter_provider.dart';
import 'package:complaint_portal/features/home/filtered_complaints_text_section.dart';
import 'package:complaint_portal/features/home/top_section_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        "selectedDateRange": null
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("homePage"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: const [
              HomeScreenTopSection(),
              FilterDialog(),
              FilterTextSection(),
              FilteredComplaints(),
            ],
          ),
        ),
      ),
    );
  }
}
