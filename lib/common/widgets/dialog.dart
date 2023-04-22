import 'package:flutter/material.dart';
import 'package:get/get.dart';

dialogResult(title, content) async {
  final result = await Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text('Yes'),
        ),
      ],
    ),
  );
  return result;
}
