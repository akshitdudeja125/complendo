// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// Future<String?> showDropDownDialog({
//   required String title,
//   required List<String> items,
// }) async {
//   //show dialog
//   final context = Get.context!;

//   // showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         title: Text(title),
//   //         content: SizedBox(
//   //           // height: 400,
//   //           //take the required height
//   //           // height: items.length * 55  or 200 whichever is less
//   //           height: items.length * 55 > 200 ? 200 : items.length * 55,
//   //           child: ListView.builder(
//   //             itemCount: items.length,
//   //             itemBuilder: (context, index) {
//   //               return ListTile(
//   //                 title: Text(items[index]),
//   //                 onTap: () {
//   //                   Get.back(result: items[index]);
//   //                 },
//   //               );
//   //             },
//   //           ),
//   //         ),
//   //       );
//   //     });
//   // final result = await Get.defaultDialog(
//   //   title: title,
//   //   content: SizedBox(
//   //     // height: 400,
//   //     //take the required height
//   //     // height: items.length * 55  or 200 whichever is less
//   //     height: items.length * 55 > 200 ? 200 : items.length * 55,
//   //     child: ListView.builder(
//   //       itemCount: items.length,
//   //       itemBuilder: (context, index) {
//   //         return ListTile(
//   //           title: Text(items[index]),
//   //           onTap: () {
//   //             Get.back(result: items[index]);
//   //           },
//   //         );
//   //       },
//   //     ),
//   //   ),
//   // );
//   // return result;
// }

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
