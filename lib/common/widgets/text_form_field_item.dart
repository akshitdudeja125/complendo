import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
  int? maxLength;
  Color? textColor;
  FontWeight? fontWeight;
  IconData? suffixIcon;
  Function()? onSuffixTap;
  Function()? onDelete;
  bool allowDelete = false;
  bool enabled;

  Function()? onTap;

  Widget? suffix;
  TextFormFieldItem({
    super.key,
    this.initValue,
    this.controller,
    required this.labelText,
    this.validator,
    this.maxLines = 1,
    this.canEdit = true,
    this.onChanged,
    this.keyboardType,
    this.obsureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
    this.maxLength,
    this.textColor,
    this.fontWeight,
    this.onSuffixTap,
    this.suffix,
    this.allowDelete = false,
    this.onDelete,
    this.enabled = true,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // color: Colors.white.withOpacity(0.5),
        ),
        child: TextFormField(
          strutStyle: const StrutStyle(
            height: 1.5,
          ),
          initialValue: initValue,
          cursorColor: Theme.of(context).colorScheme.secondary,
          autofocus: true,
          enableSuggestions: true,
          readOnly: !canEdit!,
          cursorHeight: 20,
          validator: validator,
          autocorrect: false,
          obscureText: obsureText!,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onChanged: onChanged,
          controller: controller,
          enabled: enabled,
          textInputAction: TextInputAction.done,
          textCapitalization: textCapitalization ?? TextCapitalization.words,
          maxLength: maxLength,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
          decoration: InputDecoration(
            // fillColor: Colors.white,
            suffix: suffix ??
                (suffixIcon != null && onSuffixTap != null ||
                        allowDelete == true
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.white,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (onSuffixTap != null) {
                                onSuffixTap!();
                              } else if (allowDelete == true) {
                                onDelete!();
                              }
                            },
                            child: Icon(
                              suffixIcon ?? FeatherIcons.trash2,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    : null),
            // labelStyle: const TextStyle(color: Colors.black),
            labelStyle: ThemeData().inputDecorationTheme.labelStyle,
            focusedBorder: ThemeData().inputDecorationTheme.focusedBorder,
            enabledBorder: ThemeData().inputDecorationTheme.enabledBorder,
            errorBorder: ThemeData().inputDecorationTheme.errorBorder,
            disabledBorder: ThemeData().inputDecorationTheme.disabledBorder,
            labelText: labelText,

            border: ThemeData().inputDecorationTheme.border,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            enabled: canEdit ?? true,
            // focusedBorder: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(20)),
            //   borderSide: BorderSide(
            //     color: Colors.black,
            //   ),
            // ),
            // enabled: canEdit ?? true,
            // enabledBorder: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(20)),
            //   borderSide: BorderSide(
            //     color: Colors.grey,
            //   ),
            // ),
            // errorBorder: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(20)),
            //   borderSide: BorderSide(
            //     color: Colors.red,
            //   ),
            // ),
            // disabledBorder: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(20)),
            //   borderSide: BorderSide(
            //     color: Colors.grey,
            //   ),
            // ),
            // labelText: labelText,
            // border: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(
            //       20,
            //     ),
            //   ),
            //   borderSide: BorderSide(
            //       // color: Colors.black,
            //       ),
            // ),
          ),
        ),
      ),
    );
  }
}
