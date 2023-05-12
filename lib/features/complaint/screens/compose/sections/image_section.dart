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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade400
                      : Colors.black,
                ),
              ),
            ),
            const Spacer(),
            ref.watch(pickedImageProvider) == null
                ? IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.black,
                    ),
                    onPressed: () async {
                      ref.watch(pickedImageProvider.notifier).state =
                          await pickImage(ImageSource.gallery);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.black,
                    ),
                    onPressed: () async {
                      ref.watch(pickedImageProvider.notifier).state =
                          await pickImage(ImageSource.gallery);
                    },
                  ),
            ref.watch(pickedImageProvider) == null
                ? IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.black,
                    ),
                    onPressed: () async {
                      ref.watch(pickedImageProvider.notifier).state =
                          await pickImage(ImageSource.camera);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.black,
                    ),
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
