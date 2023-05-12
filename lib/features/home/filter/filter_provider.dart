import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredOptionsProvider =
    StateProvider<Map<String, List<String>>>((ref) => {
          "status": [],
          "category": [],
          "hostel": [],
        });
