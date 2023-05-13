import 'package:flutter_riverpod/flutter_riverpod.dart';

final complaintFilterOptionsProvider =
    StateProvider<Map<String, List<String>>>((ref) => {
          "status": [],
          "category": [],
          "hostel": [],
        });