import 'dart:io';

import 'package:complaint_portal/common/services/image_picker.dart';
import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/features/complaint/providers/edit_complaint_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade400
              : const Color.fromARGB(255, 6, 56, 97),
          // ThemeColors.containerBorderColor[Theme.of(context).brightness],
        ),
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
                      style: TextStyles(Theme.of(context).brightness)
                          .complaintTextMedium),
                ),
                const Spacer(),
                if (loading == false)
                  IconButton(
                    icon: image == null
                        ? Icon(
                            Icons.image,
                            color: ThemeColors
                                .iconColorLight[Theme.of(context).brightness],
                          )
                        : Icon(
                            Icons.edit,
                            color: ThemeColors
                                .iconColorLight[Theme.of(context).brightness],
                          ),
                    onPressed: () async {
                      if (loading) return;
                      ref.watch(imageProvider.notifier).state =
                          await pickImage(ImageSource.gallery);
                    },
                  ),
                if (loading == false)
                  image == null
                      ? IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: ThemeColors
                                .iconColorLight[Theme.of(context).brightness],
                          ),
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
