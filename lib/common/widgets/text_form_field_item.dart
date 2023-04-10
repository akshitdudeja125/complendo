// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFormFieldItem extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? Function(String?)? validator;
  final int maxLines;
  bool? canEdit;
  String? initValue;
  Function(String)? onChanged;
  TextInputType? keyboardType;
  bool? obsureText;
  TextCapitalization? textCapitalization;

  TextFormFieldItem({
    this.initValue,
    super.key,
    this.controller,
    required this.labelText,
    this.validator,
    this.maxLines = 1,
    this.canEdit = true,
    this.onChanged,
    this.keyboardType,
    this.obsureText = false,
    this.textCapitalization = TextCapitalization.none,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white.withOpacity(0.5),
      ),
      child: TextFormField(
        initialValue: initValue,
        autofocus: true,
        enableSuggestions: true,
        cursorHeight: 20,
        validator: validator,
        autocorrect: false,
        obscureText: obsureText!,
        maxLines: maxLines,
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controller,
        enabled: canEdit,
        textCapitalization: textCapitalization!,
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
      ),
    );
  }
}
