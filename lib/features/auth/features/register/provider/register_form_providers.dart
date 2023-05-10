import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/utils/enums.dart';

final hostelProvider = StateProvider<String?>((ref) => null);
final isLoadingProvider = StateProvider((ref) => false);
final roomNoProvider = StateProvider<String?>((ref) => "");
final rollNoProvider = StateProvider<String?>((ref) => "");
final phoneNoProvider = StateProvider<String?>((ref) => "");
final formKeyProvider = StateProvider((ref) => GlobalKey<FormState>());
