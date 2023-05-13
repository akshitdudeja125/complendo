import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';

class UserDataSection extends StatelessWidget {
  const UserDataSection({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    debugPrint('UserDataSection build');
    return Column(
      children: [
        TextFormFieldItem(
          initValue: user.name,
          canEdit: false,
          labelText: 'Name',
          enabled: false,
        ),
        const SizedBox(height: kFormSpacing),
        TextFormFieldItem(
          initValue: user.email,
          labelText: 'Email',
          canEdit: false,
          enabled: false,
        ),
        const SizedBox(height: kFormSpacing),
        TextFormFieldItem(
          initValue: user.rollNo,
          labelText: 'Roll Number',
          canEdit: false,
          enabled: false,
          textCapitalization: TextCapitalization.characters,
        ),
      ],
    );
  }
}
