import 'package:flutter/material.dart';

class TextFormFieldItem extends StatelessWidget {
  const TextFormFieldItem({
    super.key,
    required TextEditingController controller,
    required this.labelText,
    this.validator,
    this.maxLines = 1,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelText;
  final String? Function(String?)? validator;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator != null ? null : validator,
      autocorrect: false,
      maxLines: maxLines,
      keyboardType: labelText == 'Room No.'
          ? TextInputType.number
          : labelText == 'Email'
              ? TextInputType.emailAddress
              : TextInputType.text,
      controller: _controller,
      obscureText: labelText == 'Password' ? true : false,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        labelText: labelText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }
}
