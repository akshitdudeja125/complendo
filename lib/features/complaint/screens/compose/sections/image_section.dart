import 'package:complaint_portal/common/services/image_picker.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                  ref.watch(pickedImageProvider) == null
                      ? 'Upload an Image'
                      : "Uploaded Image",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF181D3D))),
            ),
            const Spacer(),
            ref.watch(pickedImageProvider) == null
                ? IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () async {
                      ref.watch(pickedImageProvider.notifier).state =
                          await pickImage(ImageSource.gallery);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      ref.watch(pickedImageProvider.notifier).state =
                          await pickImage(ImageSource.gallery);
                    },
                  ),
            ref.watch(pickedImageProvider) == null
                ? IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () async {
                      ref.watch(pickedImageProvider.notifier).state =
                          await pickImage(ImageSource.camera);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        ref.watch(pickedImageProvider.notifier).state = null,
                  ),
          ],
        ),
        if (ref.watch(pickedImageProvider) != null)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.file(
              ref.watch(pickedImageProvider)!,
              height: 200,
              width: 200,
            ),
          ),
      ],
    );
  }
}
