import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String?> showDropDownDialog({
  required String title,
  required List<String> items,
}) {
  return Get.dialog(
    Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...items
                .map(
                  (e) => ListTile(
                    title: Text(e),
                    onTap: () {
                      Get.back(result: e);
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ),
    ),
  );
}
