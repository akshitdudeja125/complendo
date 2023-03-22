// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'complaint_model.dart';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromMap(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

// enum Hostel { RHR, BHR, MHR, GHR, SHR }

class UserModel {
  final String id;
  final String? rollNo;
  final String name;
  final String email;
  final String? hostel;
  final String? roomNo;
  final String? photoURL;
  final String? phoneNumber;
  final bool? isAdmin;
  final bool? isProfileComplete;
  final List<String>? complaints;

  UserModel({
    required this.id,
    this.rollNo,
    required this.name,
    required this.email,
    this.hostel,
    this.phoneNumber,
    this.roomNo,
    this.photoURL,
    this.isAdmin,
    this.isProfileComplete,
    this.complaints,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      rollNo: data['rollNo'],
      isAdmin: data['isAdmin'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      hostel: data['hostel'],
      roomNo: data['roomNo'],
      photoURL: data['photoURL'],
      isProfileComplete: data['isProfileComplete'],
      complaints: data['complaints'],
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
      'phoneNumber': phoneNumber,
      'roomNo': roomNo,
      'photoURL': photoURL,
      'isProfileComplete': isProfileComplete,
      'complaints': complaints,
    };
  }
}
