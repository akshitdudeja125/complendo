import 'package:flutter/material.dart';

loadingDialogue(BuildContext context) {
  return AlertDialog(
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF181D3D)),
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("  Registering...")),
        ],
      ),
    ),
  );
}
