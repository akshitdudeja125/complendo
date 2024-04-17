import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() onClick;
  final String text;
  final Color? bgColor;
  final double? maxWidth;
  final Color? textColor;
  const CustomElevatedButton({
    super.key,
    required this.onClick,
    this.bgColor,
    required this.text,
    this.maxWidth,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      // constraints: BoxConstraints(
      //   maxWidth: maxWidth ?? 230,
      // ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ??
              ThemeColors.elevatedButtonColor[Theme.of(context).brightness],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onClick,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            // elevatedButtonTextStyle
            // style: TextStyles(Theme.of(context).brightness)
            //     .elevatedButtonTextStyle,
            style: TextStyle(
              color: textColor ??
                  ThemeColors
                      .elevatedButtonTextColor[Theme.of(context).brightness],
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
