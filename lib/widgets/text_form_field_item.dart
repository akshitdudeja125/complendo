import 'package:flutter/material.dart';

class TextFormFieldItem extends StatelessWidget {
  TextFormFieldItem({
    super.key,
    required TextEditingController controller,
    required this.labelText,
    this.canEdit = true,
    this.validator,
    this.maxLines = 1,
  }) : _controller = controller;

  final TextEditingController? _controller;
  final String labelText;
  final String? Function(String?)? validator;
  final int maxLines;
  bool? canEdit;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 20,
      validator: validator,
      autocorrect: false,
      maxLines: maxLines,
      keyboardType: labelText == 'Room No.'
          ? TextInputType.number
          : labelText == 'Email'
              ? TextInputType.emailAddress
              : TextInputType.text,
      controller: _controller,
      enabled: canEdit,
      obscureText: labelText == 'Password' ? true : false,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black)),
        labelText: labelText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }
}
