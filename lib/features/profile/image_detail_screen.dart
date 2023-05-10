import 'package:flutter/material.dart';
import 'package:popup_banner/popup_banner.dart';

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  const DetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: Image.network(
            imageUrl,
          ),
        ),
      ),
    );
  }
}

AlertDialog alertDialog({
  required String title,
  required TextEditingController controller,
  String? hintText,
  Function()? onSubmit,
}) =>
    AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter new phone number",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text("Change"),
          ),
        ],
      ),
    );

void showDefaultPopup({
  required BuildContext context,
  required List<String> images,
}) {
  PopupBanner(
    fit: BoxFit.contain,
    fromNetwork: true,
    context: context,
    images: images,
    onClick: (index) {
      debugPrint("CLICKED $index");
    },
  ).show();
}
