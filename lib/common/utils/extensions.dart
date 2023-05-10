import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}".toString();
  }
}

//date formatter
extension DateTimeExtension on DateTime {
  String get formattedDate {
    return DateFormat.yMMMMd().add_jm().format(this).toString();
  }
}
