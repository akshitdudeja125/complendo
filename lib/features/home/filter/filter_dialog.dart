import 'package:complaint_portal/features/home/filter/filter_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        "Complaints:",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(FeatherIcons.filter),
        onPressed: () async {
          return await Get.dialog(
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text("Filter Options"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: const [
                        FilterSection(
                          headerText: 'Status',
                          filtername: 'status',
                        ),
                        FilterSection(
                          headerText: 'Category',
                          filtername: 'category',
                        ),
                        FilterSection(
                          headerText: 'Hostel',
                          filtername: 'hostel',
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Done"),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}