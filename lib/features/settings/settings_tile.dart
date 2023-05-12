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
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
                    // color: Theme.of(context).iconTheme.color,
                  )
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
                  )),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle ?? "",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .color!
                    .withOpacity(0.5),
              ),
        ),
        trailing: trailing ??
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultSpacing),
              child: Icon(
                trailingIcon,
                size: 20,
                color: Theme.of(context).iconTheme.color!.withOpacity(0.5),
              ),
            ),
      ),
    );
  }
}
