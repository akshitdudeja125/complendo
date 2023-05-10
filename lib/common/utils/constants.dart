import 'package:flutter/material.dart';

import 'enums.dart';


List<String> complaintCategories = [
  'Electrical',
  'Plumbing',
  'Internet',
  'Water Cooler',
];

Map<UserType, String> userTypeToComplaintTypeMap = {
  UserType.electrician: "Electrical",
  UserType.plumber: "Plumbing",
};

final Map<String, String> categoryImageMap = {
  'Electrical': 'assets/images/complaint_icons/electric.png',
  'Internet': 'assets/images/complaint_icons/internet.png',
  'Plumbing': 'assets/images/complaint_icons/water.png',
  'Water Cooler': 'assets/images/complaint_icons/water-dispenser.png',
};

final filterOptions = {
  "status": ["pending", "resolved", "rejected"],
  "hostel": Hostel.getHostels(),
  "category": complaintCategories
};

double kFormSpacing = 20;

const double kDefaultSpacing = 16.0;

const Color kPrimaryColor = Color(0xFF181D3D);

const String devName = "Akshit Dudeja";
const String devEmail = "dudejaakshit@gmail.com";
const String devPhone = "9643798169";

List<String> terms = [
  "1.User Conduct: You are solely responsible for the content of your complaints and any other information you provide on the portal. You agree not to post any abusive, offensive, or discriminatory content.",
  "2.Confidentiality: We take the privacy of our users seriously. We will not disclose any personal information or details about the complaint to any third party without the user's consent.",
  "3.Use of Information: The information provided by the user will be used to investigate and address the complaint. We reserve the right to share the complaint and its details with relevant authorities or third parties, if necessary.",
  "4.Intellectual Property: All content on the complaint portal application is owned by us and is protected by intellectual property laws. You agree not to use, reproduce, or distribute any content without our prior written consent.",
  "5.Limitation of Liability: We are not responsible for any damages or losses incurred as a result of using the complaint portal application. We do not guarantee the accuracy or completeness of the information provided on the portal",
  "6.Indemnification: You agree to indemnify us, our affiliates, and our employees from any claims, damages, or losses arising from your use of the complaint portal application.",
  "7.Termination: We reserve the right to terminate your access to the complaint portal application at any time and for any reason.",
  "8.Modifications: We reserve the right to modify these terms and conditions at any time. If we make any changes, we will notify you by revising the date at the top of the terms and conditions, and, in some cases, we may provide you with additional notice (such as adding a statement to our homepage or sending you a notification). We encourage you to review the terms and conditions whenever you use our services to stay informed about our information practices and the ways you can help protect your privacy.",
  "9. If you have any questions about these terms and conditions, please contact us."
];
