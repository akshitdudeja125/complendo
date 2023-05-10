import 'package:complaint_portal/common/utils/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);
final imageProvider = StateProvider<dynamic>((ref) => null);
// final hostelProvider = StateProvider<String?>((ref) => "");
final hostelProvider = StateProvider<Hostel?>((ref) => null);
