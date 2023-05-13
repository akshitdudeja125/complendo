import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/common/widgets/dropdown_dialog.dart';
import 'package:complaint_portal/common/widgets/submit_button.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/features/register/provider/register_form_providers.dart';
import 'package:complaint_portal/features/auth/features/register/services/register_form_submit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(formKeyProvider.notifier).state = GlobalKey<FormState>();
      ref.read(rollNoProvider.notifier).state = '';
      ref.read(phoneNoProvider.notifier).state = '';
      ref.read(roomNoProvider.notifier).state = '';
      ref.read(hostelProvider.notifier).state = '';
    });
  }

  @override
  void dispose() {
    phoneNoController.dispose();
    roomNoController.dispose();
    hostelController.dispose();
    rollNoController.dispose();

    super.dispose();
  }

  late final phoneNoController = TextEditingController();
  late final roomNoController = TextEditingController();
  late final rollNoController = TextEditingController();
  late final hostelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final user = ref.watch(authUserProvider)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: ref.watch(formKeyProvider),
        child: Column(
          children: [
            TextFormFieldItem(
              initValue: user.displayName,
              enabled: false,
              labelText: 'Name',
            ),
            const SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              initValue: user.email,
              labelText: 'Email',
              enabled: false,
              canEdit: false,
            ),
            const SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              controller: rollNoController,
              onChanged: (value) {
                ref.read(rollNoProvider.notifier).state = value;
              },
              textCapitalization: TextCapitalization.characters,
              labelText: 'Roll No.',
              allowDelete: !isLoading,
              enabled: !isLoading,
              onDelete: () {
                rollNoController.clear();
                ref.watch(rollNoProvider.notifier).state = null;
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your roll number';
                }
                return null;
              },
            ),
            const SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              keyboardType: TextInputType.phone,
              onChanged: (value) =>
                  ref.read(phoneNoProvider.notifier).state = value,
              controller: phoneNoController,
              labelText: 'PhoneNumber',
              allowDelete: !isLoading,
              enabled: !isLoading,
              onDelete: () {
                phoneNoController.clear();
                ref.watch(roomNoProvider.notifier).state = null;
              },
              validator: (String? value) {
                return isPhoneNumber(value!);
              },
            ),
            const SizedBox(height: kFormSpacing),
            // TextFormFieldItem(
            //   labelText: 'Hostel',
            //   controller: TextEditingController(
            //       text: ref.watch(hostelProvider).toString()),
            //   enabled: !isLoading,
            //   suffixIcon: isLoading ? null : FeatherIcons.chevronDown,
            //   canEdit: false,
            //   onSuffixTap: () async {
            //     final selected = await showDropDownDialog(
            //       title: 'Select Hostel',
            //       items: Hostel.getHostels(),
            //     );
            //     if (selected != null) {
            //       ref.watch(hostelProvider.notifier).state = selected;
            //     }
            //   },
            // ),
            TextFormFieldItem(
              labelText: 'Hostel',
              controller: TextEditingController(
                  text: ref.watch(hostelProvider).toString()),
              enabled: !isLoading,
              suffixIcon: isLoading ? null : FeatherIcons.chevronDown,
              canEdit: false,
              onSuffixTap: () async {
                final selected = await showDropDownDialog(
                  title: 'Select Hostel',
                  items: Hostel.getHostels(),
                );
                if (selected != null) {
                  ref.watch(hostelProvider.notifier).state = selected;
                }
              },
            ),

            // customDropDownMenu(
            //   context: context,
            //   headerText: "Hostel:",
            //   items: Hostel.getHostels(),
            //   hintText: "Select Hostel",
            //   value: ref.watch(hostelProvider),
            //   onChanged: (value) =>
            //       ref.watch(hostelProvider.notifier).state = value,
            // ),
            const SizedBox(height: kFormSpacing),
            TextFormFieldItem(
              onChanged: (value) =>
                  ref.read(roomNoProvider.notifier).state = value,
              labelText: 'Room No.',
              allowDelete: !isLoading,
              enabled: !isLoading,
              onDelete: () {
                ref.watch(roomNoProvider.notifier).state = null;
              },
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your room no.';
              //   }
              //   return null;
              // },
            ),
            const SizedBox(height: kFormSpacing),
            SubmitButton(
              isLoadingProvider: isLoadingProvider,
              onClick: () {
                setProfile(ref);
              },
            ),
            const SizedBox(height: kFormSpacing),
            CustomElevatedButton(
              maxWidth: 200,
              bgColor: Colors.red.shade300,
              onClick: () {
                ref.read(authRepositoryProvider).signOut(ref);
              },
              text: 'Sign Out',
            ),
          ],
        ),
      ),
    );
  }
}
