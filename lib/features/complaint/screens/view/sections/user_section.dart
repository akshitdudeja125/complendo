import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/complaint/screens/view/provider/section_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:complaint_portal/models/user_model.dart';

class PersonalDetailsSection extends StatelessWidget {
  const PersonalDetailsSection({
    super.key,
    required this.ref,
    required this.complaintUser,
  });

  final WidgetRef ref;
  final UserModel complaintUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Personal Details",
              style: TextStyles(Theme.of(context).brightness).detailsTextStyle,
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                ref.read(pdProvider.notifier).state =
                    !ref.read(pdProvider.notifier).state;
              },
              child: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color:
                    ThemeColors.dropDownIconColor[Theme.of(context).brightness],
              ),
            ),
          ],
        ),
        Consumer(
          builder: (context, ref, _) {
            final pdv = ref.watch(pdProvider);
            return Visibility(
              visible: pdv,
              child: Column(
                children: [
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    controller: TextEditingController(text: complaintUser.name),
                    canEdit: false,
                    labelText: 'Name',
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    controller:
                        TextEditingController(text: complaintUser.email),
                    labelText: 'Email',
                    canEdit: false,
                  ),
                  SizedBox(height: kFormSpacing),
                  TextFormFieldItem(
                    controller:
                        TextEditingController(text: complaintUser.rollNo),
                    labelText: 'Roll Number',
                    canEdit: false,
                    textCapitalization: TextCapitalization.characters,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
