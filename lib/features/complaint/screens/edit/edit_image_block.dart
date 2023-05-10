import 'dart:io';

import 'package:complaint_portal/common/services/image_picker.dart';
import 'package:complaint_portal/features/complaint/providers/edit_complaint_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class EditImageBlock extends StatelessWidget {
  const EditImageBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black.withOpacity(0.3)),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Consumer(builder: (context, ref, child) {
        debugPrint("Edit Complaint Page: Image Consumer");
        final image = ref.watch(imageProvider);
        final loading = ref.watch(isLoadingProvider);
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      image == null ? 'Upload an Image' : "Uploaded Image",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF181D3D))),
                ),
                const Spacer(),
                if (loading == false)
                  IconButton(
                    icon: image == null
                        ? const Icon(Icons.image)
                        : const Icon(Icons.edit),
                    onPressed: () async {
                      if (loading) return;
                      ref.watch(imageProvider.notifier).state =
                          await pickImage(ImageSource.gallery);
                    },
                  ),
                if (loading == false)
                  image == null
                      ? IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () async {
                            if (loading) return;
                            ref.watch(imageProvider.notifier).state =
                                await pickImage(ImageSource.camera);
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            if (loading) return;
                            ref.watch(imageProvider.notifier).state = null;
                          },
                        ),
              ],
            ),
            if (image is File)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.file(
                  image,
                  height: 200,
                  width: 200,
                ),
              ),
            if (image is String && image != '')
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  image,
                  height: 200,
                  width: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
