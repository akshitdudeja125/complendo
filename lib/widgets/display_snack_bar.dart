import 'package:flutter/material.dart';
import 'package:get/get.dart';

displaySnackBar(String title, String message,
    {SnackPosition snackPosition = SnackPosition.BOTTOM,
    Color backgroundColor = Colors.black,
    Color colorText = Colors.white,
    Duration duration = const Duration(seconds: 1, milliseconds: 130)}) {
  Get.snackbar(
    duration: duration,
    title,
    message,
    snackPosition: snackPosition,
    backgroundColor: backgroundColor,
    colorText: colorText,
  );
}
