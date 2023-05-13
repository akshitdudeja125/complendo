import 'package:flutter_riverpod/flutter_riverpod.dart';

final userFilterOptionsProvider = StateProvider<Map<String, dynamic>>((ref) => {
      "hostel": [],
      "usertype": [],
      "status": [],
      "search": "",
    });
