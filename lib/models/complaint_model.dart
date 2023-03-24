import 'dart:convert';

List<Complaint> complaintModelFromJson(String str) =>
    List<Complaint>.from(json.decode(str).map((x) => Complaint.fromMap(x)));

String complaintModelToJson(List<Complaint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

enum Status { pending, resolved, rejected }

enum Category { electricity, water, interet, waterCooler }


class Complaint {
  final String cid;
  final String uid;

  final String? title;
  final String? description;
  final String? category;

  final bool? isIndividual;

  final DateTime? date;
  final DateTime? resolvedDate;

  final List<String>? upvotes;

  final String? status;
  final String? imageLink;

  final String? complaintType;

  Complaint({
    required this.uid,
    required this.cid,
    this.title,
    this.isIndividual,
    this.description,
    this.category,
    this.upvotes,
    this.date,
    this.resolvedDate,
    this.status,
    this.imageLink,
    this.complaintType,
  });

  factory Complaint.fromMap(Map<String, dynamic> data) {
    return Complaint(
      uid: data['uid'],
      cid: data['id'],
      isIndividual: data['isIndividual'],
      title: data['title'],
      description: data['description'],
      category: data['category'],
      upvotes: data['upvotes'],
      date: data['date'],
      resolvedDate: data['resolvedDate'],
      status: data['status'],
      imageLink: data['imageLink'],
      complaintType: data['complaintType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': cid,
      'uid': uid,
      'title': title,
      'description': description,
      'isIndividual': isIndividual,
      'category': category,
      'upvotes': upvotes,
      'date': date,
      'resolvedDate': resolvedDate,
      'status': status,
      'imageLink': imageLink,
      'complaintType': complaintType,
    };
  }
}
