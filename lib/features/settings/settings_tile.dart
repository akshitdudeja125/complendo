import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  String? imageUrl;
  String? subtitle;
  IconData? iconData;
  // IconData? trailingIcon;
  IconData? trailingIcon;
  final VoidCallback? onTap;
  Widget? trailing;
  SettingsTile({
    super.key,
    required this.title,
    this.subtitle = "",
    this.imageUrl,
    this.iconData,
    this.onTap,
    this.trailing,
    this.trailingIcon = Icons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Padding(
            padding: subtitle == ""
                ? const EdgeInsets.symmetric(horizontal: 8)
                : const EdgeInsets.all(8),
            child: imageUrl == null
                ? Icon(
                    iconData,
                    size: 30,
                    color: ThemeColors
                        .settingsIconColor[Theme.of(context).brightness],
                  )
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                    color: ThemeColors
                        .settingsIconColor[Theme.of(context).brightness],
                  )),
        title: Text(
          title,
          style:
              TextStyles(Theme.of(context).brightness).settingsTitleTextStyle,
        ),
        subtitle: Text(
          subtitle ?? "",
          style: TextStyles(Theme.of(context).brightness)
              .settingsSubtitleTextStyle,
        ),
        trailing: trailing ??
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultSpacing),
              child: Icon(
                trailingIcon,
                size: 20,
                color:
                    ThemeColors.settingsIconColor[Theme.of(context).brightness],
              ),
            ),
      ),
    );
  }
}
