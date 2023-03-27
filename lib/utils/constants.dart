import 'package:complaint_portal/screens/profile/student_profile.dart';
import 'package:complaint_portal/screens/compose_complaint_screen.dart';
import 'package:flutter/material.dart';

List<String> hostels = [
  "RHR",
  "BHR",
  "MHR",
  "GHR",
  "SHR",
];

List<String> complaintCategories = [
  'Electricity',
  'Water',
  'Internet',
  'Water Cooler',
];

double kFormSpacing = 20;

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

/// dimensions
const double defaultSpacing = 16.0;
const double defaultRadius = 12.0;

const double fontSizeHeading = 20.0;
const double fontSizeTitle = 18.0;
const double fontSizeBody = 13.0;

const Color kPrimaryColor = Color(0xFF181D3D);
