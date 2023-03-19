// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromMap(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

// enum Hostel { RHR, BHR, MHR, GHR, SHR }

class UserModel {
  final String id;
  final String rollNo;
  final String name;
  final String email;
  final String hostel;
  final String roomNo;
  final String photoURL;
  final bool isAdmin;

  UserModel({
    required this.isAdmin,
    required this.id,
    required this.rollNo,
    required this.name,
    required this.email,
    required this.hostel,
    required this.roomNo,
    required this.photoURL,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      rollNo: data['rollNo'],
      name: data['name'],
      email: data['email'],
      hostel: data['hostel'],
      roomNo: data['roomNo'],
      photoURL: data['photoURL'],
      isAdmin: data['isAdmin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rollNo': rollNo,
      'isAdmin': isAdmin,
      'name': name,
      'email': email,
      'hostel': hostel,
      'roomNo': roomNo,
      'photoURL': photoURL,
    };
  }
}
