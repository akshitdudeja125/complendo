import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/auth/repository/auth_repository.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/custom_drop_down_menu.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/features/register/provider/register_form_providers.dart';
import 'package:complaint_portal/features/auth/features/register/services/register_form_submit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authUserProvider)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: ref.watch(formKeyProvider),
        child: Column(
          children: [
            TextFormFieldItem(
              initValue: user.displayName,
              canEdit: false,
              labelText: 'Name',
            ),
            SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              initValue: user.email,
              labelText: 'Email',
              canEdit: false,
            ),
            SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              onChanged: (value) =>
                  ref.read(rollNoProvider.notifier).state = value.toUpperCase(),
              textCapitalization: TextCapitalization.characters,
              labelText: 'Roll No.',
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your roll number';
                }
                return null;
              },
            ),
            SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              keyboardType: TextInputType.phone,
              onChanged: (value) =>
                  ref.read(phoneNoProvider.notifier).state = value,
              labelText: 'PhoneNumber',
              validator: (String? value) {
                return isPhoneNumber(value!);
              },
            ),
            const SizedBox(height: 20),
            customDropDownMenu(
              context: context,
              headerText: "Hostel:",
              items: hostels,
              hintText: "Select Hostel",
              value: ref.watch(hostelProvider),
              onChanged: (value) =>
                  ref.watch(hostelProvider.notifier).state = value,
            ),
            SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              onChanged: (value) =>
                  ref.read(roomNoProvider.notifier).state = value,
              labelText: 'Room No.',
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your room no.';
                }
                return null;
              },
            ),
            SizedBox(height: kFormSpacing),
            SubmitButton(
              isLoadingProvider: isLoadingProvider,
              onClick: () {
                setProfile(ref);
              },
            ),
            CustomElevatedButton(
              bgColor: Colors.red.shade300,
              onClick: () {
                AuthService().signOut(ref);
              },
              text: 'Sign Out',
            ),
          ],
        ),
      ),
    );
  }
}
