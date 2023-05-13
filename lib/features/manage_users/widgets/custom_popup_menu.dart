import 'package:flutter/material.dart';

PopupMenuItem customPopUpMenuItem({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Function onTap,
}) {
  return PopupMenuItem(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey[300],
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey[600]
              : Colors.grey[300],
        ),
        child: ListTile(
          onTap: () {
            onTap();
          },
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
