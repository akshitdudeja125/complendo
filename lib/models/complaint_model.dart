import 'dart:convert';

import 'package:complaint_portal/models/user_model.dart';

List<Complaint> complaintModelFromJson(String str) =>
    List<Complaint>.from(json.decode(str).map((x) => Complaint.fromMap(x)));

String complaintModelToJson(List<Complaint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

enum Status { pending, resolved, rejected }

enum Category { electricity, water, interet, waterCooler }

class Student {
  String uid;
  String name;
  String rollNo;
  String email;

  Student({
    required this.uid,
    required this.rollNo,
    required this.name,
    required this.email,
  });
}

class Complaint {
  final String cid;
  final String? title;
  final String? description;
  // final Category? category;
  final String? category;
  final Student? student;
  List<Student>? upvotes;
  final DateTime? date;
  final DateTime? resolvedDate;
  final Status? status;

  Complaint({
    required this.cid,
    this.title,
    this.description,
    this.category,
    this.student,
    this.upvotes,
    this.date,
    this.resolvedDate,
    this.status,
  });

  factory Complaint.fromMap(Map<String, dynamic> data) {
    return Complaint(
      cid: data['id'],
      title: data['title'],
      description: data['description'],
      category: data['category'],
      student: data['student'],
      upvotes: data['upvotes'],
      date: data['date'],
      resolvedDate: data['resolvedDate'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': cid,
      'title': title,
      'description': description,
      'category': category,
      'student': student,
      'upvotes': upvotes,
      'date': date,
      'resolvedDate': resolvedDate,
      'status': status,
    };
  }
}

// List<Complaint> complaints = [
//   Complaint(
//     id: '1',
//     title: 'Water Cooler not working',
//     description: 'Water Cooler is not working since 2 days',
//     category: Category.waterCooler,
//     upvotes: [],
//     status: Status.pending,
//     date: DateTime.now(),
//     resolvedDate: DateTime.now(),
//     student: Student(

//       rollNo: '2018CSB1052',
//       name: 'Rahul',
//       email: '',
//     ),
//   ),
//   Complaint(
//     id: '2',
//     title: 'Internet not working',
//     description: 'Internet is not working since 2 days',
//     category: Category.interet,
//     upvotes: [],
//     status: Status.pending,
//     date: DateTime.now(),
//     resolvedDate: DateTime.now(),
//     student: Student(
//       rollNo: '2108CSB1052',
//       name: 'Akshit',
//       email: '21cs01026@iitbbs.ac.in',
//     ),
//   ),
// ];
