import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

imageDialog({
  required String imageLink,
}) {
  Get.dialog(
    Dialog(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 300,
        width: 300,
        child: PhotoView(
          gestureDetectorBehavior: HitTestBehavior.opaque,
          backgroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          imageProvider: NetworkImage(
            imageLink,
          ),
          loadingBuilder: (context, event) => const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    ),
  );
}
