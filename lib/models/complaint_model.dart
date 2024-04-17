// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:complaint_portal/common/utils/enums.dart';

class Complaint {
  final String? cid;
  final String? uid;
  final String? title;
  final String? description;
  final String? category;

  final String? roomNo;
  // final String? hostel;
  final Hostel? hostel;

  final bool? isIndividual;

  final DateTime? date;
  final DateTime? resolvedAt;

  // comment
  final String? comment;

  final String? resolvedBy;

  final List<String>? upvotes;
  final List<String>? downvotes;

  final ComplaintStatus? status;
  final String? complaintType;

  final String? imageLink;

  Complaint({
    this.comment,
    this.roomNo,
    this.hostel,
    this.cid,
    this.uid,
    this.title,
    this.description,
    this.category,
    this.isIndividual,
    this.date,
    this.resolvedAt,
    this.upvotes,
    this.downvotes,
    this.status,
    this.imageLink,
    this.complaintType,
    this.resolvedBy,
  });

  Complaint copyWith({
    String? cid,
    String? uid,
    String? title,
    String? description,
    String? category,
    bool? isIndividual,
    DateTime? date,
    DateTime? resolvedAt,
    List<String>? downvotes,
    List<String>? upvotes,
    String? status,
    String? complaintType,
    String? imageLink,
    Hostel? hostel,
    String? roomNo,
    String? resolvedBy,
    String? comment,
  }) {
    return Complaint(
      cid: cid ?? this.cid,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isIndividual: isIndividual ?? this.isIndividual,
      date: date ?? this.date,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      // status: status ?? this.status,
      status: status != null
          ? ComplaintStatus.values.firstWhere((e) => e.toString() == status)
          : this.status,
      complaintType: complaintType ?? this.complaintType,
      imageLink: imageLink ?? this.imageLink,
      hostel: hostel ?? this.hostel,
      roomNo: roomNo ?? this.roomNo,
      resolvedBy: resolvedBy ?? this.resolvedBy,
      comment: comment ?? this.comment,
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
      'resolvedAt': resolvedAt,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'status': status?.toString(),
      'complaintType': complaintType,
      'imageLink': imageLink,
      'hostel': hostel?.value,
      'roomNo': roomNo,
      'resolvedBy': resolvedBy,
      'comment': comment,
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
      upvotes: data['upvotes'] != null
          ? List<String>.from(data['upvotes'] as List<dynamic>)
          : [],
      downvotes: data['downvotes'] != null
          ? List<String>.from(data['downvotes'] as List<dynamic>)
          : [],
      date: data['date']?.toDate(),
      // resolvedAt: data['resolvedAt']?.toDate(),
      resolvedAt:
          data['resolvedAt'] != null ? data['resolvedAt'].toDate() : null,
      status: data['status'] != null
          ? ComplaintStatus.values
              .firstWhere((e) => e.toString() == data['status'])
          : null,
      hostel: data['hostel'] != null
          ? Hostel.fromString(data['hostel'] as String)
          : null,
      // imageLink: data['imageLink'] as String,
      imageLink: data['imageLink'] != null ? data['imageLink'] as String : null,
      complaintType: data['complaintType'] as String,
      // roomNo: data['roomNo'] as String,
      roomNo: data['roomNo'] != null ? data['roomNo'] as String : null,
      // resolvedBy: data['resolvedBy'] as String,
      resolvedBy:
          data['resolvedBy'] != null ? data['resolvedBy'] as String : null,
      // comment: data['comment'] as String,
      comment: data['comment'] != null ? data['comment'] as String : null,
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
      date: map['date']?.toDate(),
      resolvedAt: map['resolvedAt']?.toDate(),
      // upvotes: map['upvotes'] as List<String>,
      upvotes: map['upvotes'] != null
          ? List<String>.from(map['upvotes'] as List<dynamic>)
          : [],
      downvotes: map['downvotes'] != null
          ? List<String>.from(map['downvotes'] as List<dynamic>)
          : [],
      status: map['status'] != null
          ? ComplaintStatus.values
              .firstWhere((e) => e.toString() == map['status'])
          : null,
      hostel: map['hostel'] != null
          ? Hostel.fromString(map['hostel'] as String)
          : null,
      // imageLink: map['imageLink'] as String,
      imageLink: map['imageLink'] != null ? map['imageLink'] as String : null,
      // complaintType: map['complaintType'] as String,
      complaintType:
          map['complaintType'] != null ? map['complaintType'] as String : null,
      // roomNo: map['roomNo'] as String,
      roomNo: map['roomNo'] != null ? map['roomNo'] as String : null,
      // resolvedBy: map['resolvedBy'] as String,
      resolvedBy:
          map['resolvedBy'] != null ? map['resolvedBy'] as String : null,
      // comment: map['comment'] as String,
      comment: map['comment'] != null ? map['comment'] as String : null,
    );
  }
}
