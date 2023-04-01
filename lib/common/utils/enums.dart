enum ComplaintStatus {
  pending('Pending'),
  resolved('Resolved'),
  rejected('Rejected');

  const ComplaintStatus(this.status);
  final String status;
  @override
  String toString() => status;
  static ComplaintStatus fromString(String? status) {
    return ComplaintStatus.values.firstWhere(
      (e) => e.status == status,
    );
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
