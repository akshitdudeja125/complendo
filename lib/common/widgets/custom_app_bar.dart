import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.heading,
    this.trailing,
    this.elevation,
  });
  final String? heading;
  final Widget? trailing;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: elevation ?? 0,
      title: ListTile(
        title: heading == null
            ? const SizedBox()
            : Text(
                heading!,
                style: TextStyles(Theme.of(context).brightness).appbarTextStyle,
              ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: ThemeColors.iconColorLight[Theme.of(context).brightness],
          ),
        ),
        trailing: trailing,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
