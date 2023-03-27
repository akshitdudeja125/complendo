import 'package:complaint_portal/providers/auth_provider.dart';
import 'package:complaint_portal/services/user_repository.dart';
import 'package:complaint_portal/utils/constants.dart';
import 'package:complaint_portal/utils/validators.dart';
import 'package:complaint_portal/widgets/custom_drop_down_menu.dart';
import 'package:complaint_portal/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/widgets/display_snack_bar.dart';
import 'package:complaint_portal/widgets/text_form_field_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hostelProvider = StateProvider<String?>((ref) => null);
final isLoadingProvider = StateProvider((ref) => false);
final roomNoProvider = StateProvider<String?>((ref) => "");
final phoneNoProvider = StateProvider<String?>((ref) => "");
final formKeyProvider = StateProvider((ref) => GlobalKey<FormState>());

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key});
  // final User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: ref.watch(formKeyProvider),
        child: Column(children: [
          TextFormFieldItem(
            // initValue: user.displayName,
            initValue: FirebaseAuth.instance.currentUser!.displayName,
            canEdit: false,
            labelText: 'Name',
          ),
          SizedBox(height: kFormSpacing),
          TextFormFieldItem(
            // initValue: user.email,
            initValue: FirebaseAuth.instance.currentUser!.email,
            labelText: 'Email',
            canEdit: false,
          ),
          const SizedBox(height: 20),
          TextFormFieldItem(
            // controller: _rollNumberController,
            onChanged: (value) =>
                ref.read(roomNoProvider.notifier).state = value,
            textCapitalization: TextCapitalization.characters,
            labelText: 'Roll No.',
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your roll number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormFieldItem(
            keyboardType: TextInputType.phone,
            // controller: _phoneNumberController,
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
          const SizedBox(height: 20),
          TextFormFieldItem(
            // controller: _roomNoController,
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
          const SizedBox(height: 20),
          CustomElevatedButton(
            isLoadingProvider: isLoadingProvider,
            onClick: () => setProfile(ref),
          ),
        ]),
      ),
    );
  }
}

void setProfile(ref) async {
  if (ref.watch(hostelProvider.notifier).state == null) {
    displaySnackBar('Error', 'Please select a hostel');
    return;
  }
  if (!ref.watch(formKeyProvider.notifier).state.currentState!.validate()) {
    displaySnackBar('Error', 'Please fill all the fields');
    return;
  }
  ref.watch(isLoadingProvider.notifier).state = true;

  try {
    UserRepository().updateUser(
      FirebaseAuth.instance.currentUser!.uid,
      ref.watch(roomNoProvider),
      ref.watch(phoneNoProvider),
      ref.watch(hostelProvider),
      ref.watch(roomNoProvider),
    );
  } catch (e) {
    print(e);
    displaySnackBar('Error', 'Something went wrong');
  }

  ref.watch(isLoadingProvider.notifier).state = false;
}
