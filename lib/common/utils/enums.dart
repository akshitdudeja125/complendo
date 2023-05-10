// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

enum UserType {
  student("student"),
  admin("admin"),
  dev("developer"),
  electrician("electrician"),
  warden("warden"),
  plumber("plumber");

  final String value;
  const UserType(this.value);

  static UserType fromString(String? value) {
    if (value == null) return UserType.student;
    return UserType.values.firstWhere(
      (e) => e.value == value.toLowerCase().removeAllWhitespace,
      orElse: () => UserType.student,
    );
  }

  @override
  String toString() => value.toLowerCase().removeAllWhitespace;
}

enum ComplaintStatus {
  pending('pending'),
  resolved('resolved'),
  rejected('rejected');

  const ComplaintStatus(this.value);
  final String value;
  @override
  String toString() => value;
  static ComplaintStatus fromString(String? status) {
    if (status == null) return ComplaintStatus.pending;
    return ComplaintStatus.values.firstWhere(
      (e) => e.value == status.toLowerCase().removeAllWhitespace,
    );
  }
}

enum ComplaintCategory {
  electrical('electrical'),
  plumbing('plumbing'),
  internet('internet'),
  water('water'),
  watercooler('watercooler'),
  furniture('furniture'),
  other('other');

  const ComplaintCategory(this.category);
  final String category;
  @override
  String toString() => category;
  static ComplaintCategory fromString(String? category) {
    if (category == null) return ComplaintCategory.electrical;
    return ComplaintCategory.values.firstWhere(
      (e) => e.category == category,
      orElse: () => ComplaintCategory.other,
    );
  }

  //give list of all categories
  static List<String> getCategories() {
    List<String> categories = [];
    for (var category in ComplaintCategory.values) {
      categories.add(category.category);
    }
    return categories;
  }
}

enum ComplaintType {
  individual('Individual'),
  group('Group');

  const ComplaintType(this.type);
  final String type;
  @override
  String toString() => type;
  static ComplaintType fromString(String? type) {
    return ComplaintType.values.firstWhere(
      (e) => e.type == type,
      orElse: () => ComplaintType.individual,
    );
  }
}

enum Hostel {
  RHR("RHR"),
  BHR("BHR"),
  MHR("MHR"),
  GHR("GHR"),
  SHR("SHR");

  final String value;
  const Hostel(this.value);

  static Hostel fromString(String? value) {
    if (value == null) return Hostel.RHR;
    return Hostel.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Hostel.RHR,
    );
  }

  @override
  String toString() => value;

  static List<String> getHostels() {
    List<String> hostels = [];
    for (var hostel in Hostel.values) {
      hostels.add(hostel.value);
    }
    return hostels;
  }
}
