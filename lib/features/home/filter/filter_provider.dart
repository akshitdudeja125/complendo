import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredOptionsProvider =
    StateProvider<Map<String, List<String>>>((ref) => {
          "status": [],
          "type": [],
          "hostel": [],
        });
