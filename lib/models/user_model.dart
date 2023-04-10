// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  final List<String>? complaints;
  bool? notifications;
  final String? deviceToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.rollNo,
    this.hostel,
    this.roomNo,
    this.photoURL,
    this.phoneNumber,
    this.isAdmin,
    this.complaints,
    this.notifications = true,
    this.deviceToken,
  });

  UserModel copyWith({
    String? id,
    String? rollNo,
    String? name,
    String? email,
    String? hostel,
    String? roomNo,
    String? photoURL,
    String? phoneNumber,
    bool? isAdmin,
    List<String>? complaints,
    bool? notifications,
    String? deviceToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      rollNo: rollNo ?? this.rollNo,
      name: name ?? this.name,
      email: email ?? this.email,
      hostel: hostel ?? this.hostel,
      roomNo: roomNo ?? this.roomNo,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdmin: isAdmin ?? this.isAdmin,
      complaints: complaints ?? this.complaints,
      notifications: notifications ?? this.notifications,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rollNo': rollNo,
      'name': name,
      'email': email,
      'hostel': hostel,
      'roomNo': roomNo,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
      'complaints': complaints,
      'notifications': notifications,
      'deviceToken': deviceToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      rollNo: map['rollNo'] != null ? map['rollNo'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      hostel: map['hostel'] != null ? map['hostel'] as String : null,
      roomNo: map['roomNo'] != null ? map['roomNo'] as String : null,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
      complaints: map['complaints'] != null
          ? List<String>.from(map['complaints'] as List<dynamic>)
          : null,
      notifications:
          map['notifications'] != null ? map['notifications'] as bool : null,
      deviceToken:
          map['deviceToken'] != null ? map['deviceToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
