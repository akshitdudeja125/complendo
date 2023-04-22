import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);
final imageProvider = StateProvider<dynamic>((ref) => null);
final hostelProvider = StateProvider<String?>((ref) => "");
