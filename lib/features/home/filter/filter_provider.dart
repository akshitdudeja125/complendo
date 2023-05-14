import 'package:flutter_riverpod/flutter_riverpod.dart';

final complaintFilterOptionsProvider = StateProvider<Map<String, dynamic>>(
    (ref) => {
          "status": [],
          "category": [],
          "hostel": [],
          "selectedDateRange": null
        });
