import 'package:complaint_portal/common/utils/enums.dart';

class Complaint {
  final String cid;
  final String uid;

  final String? title;
  final String? description;
  final String? category;

  final String? roomNo;
  final String? hostel;

  final bool? isIndividual;

  final DateTime? date;
  final DateTime? resolvedDate;

  final List<String>? upvotes;

  final String? status;
  final String? complaintType;

  final String? imageLink;

  Complaint({
    this.roomNo,
    this.hostel,
    required this.cid,
    required this.uid,
    this.title,
    this.description,
    this.category,
    this.isIndividual,
    this.date,
    this.resolvedDate,
    this.upvotes,
    this.status,
    this.imageLink,
    this.complaintType,
  });

  Complaint copyWith({
    String? cid,
    String? uid,
    String? title,
    String? description,
    String? category,
    bool? isIndividual,
    DateTime? date,
    DateTime? resolvedDate,
    List<String>? upvotes,
    String? status,
    String? complaintType,
    String? imageLink,
    String? hostel,
    String? roomNo,
  }) {
    return Complaint(
      cid: cid ?? this.cid,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isIndividual: isIndividual ?? this.isIndividual,
      date: date ?? this.date,
      resolvedDate: resolvedDate ?? this.resolvedDate,
      upvotes: upvotes ?? this.upvotes,
      status: status ?? this.status,
      complaintType: complaintType ?? this.complaintType,
      imageLink: imageLink ?? this.imageLink,
      hostel: hostel ?? this.hostel,
      roomNo: roomNo ?? this.roomNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'uid': uid,
      'title': title,
      'description': description,
      'category': category,
      'isIndividual': isIndividual,
      'date': date,
      'resolvedDate': resolvedDate,
      'upvotes': upvotes,
      'status': status,
      'complaintType': complaintType,
      'imageLink': imageLink,
      'hostel': hostel,
      'roomNo': roomNo,
    };
  }

  factory Complaint.fromObject(dynamic data) {
    return Complaint(
      uid: data['uid'] as String,
      cid: data['cid'] as String,
      isIndividual: data['isIndividual'] as bool,
      title: data['title'] as String,
      description: data['description'] as String,
      category: data['category'] as String,
      upvotes: data['upvotes'] as List<String>,
      date: data['date']?.toDate(),
      resolvedDate: data['resolvedDate']?.toDate(),
      status: data['status'] as String,
      imageLink: data['imageLink'] as String,
      complaintType: data['complaintType'] as String,
      hostel: data['hostel'] as String,
      roomNo: data['roomNo'] as String,
    );
  }
  factory Complaint.fromMap(Map<String, dynamic> map) {
    return Complaint(
      cid: map['cid'] as String,
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      isIndividual: map['isIndividual'] as bool,
      date: map['date'] as DateTime,
      resolvedDate: map['resolvedDate'] as DateTime,
      upvotes: map['upvotes'] as List<String>,
      status: map['status'] as String,
      imageLink: map['imageLink'] as String,
      complaintType: map['complaintType'] as String,
      hostel: map['hostel'] as String,
      roomNo: map['roomNo'] as String,
    );
  }
}
