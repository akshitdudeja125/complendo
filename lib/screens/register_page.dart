import 'package:complaint_portal/utils/constants.dart';
import 'package:complaint_portal/screens/home_screen.dart';
import 'package:complaint_portal/services/user_repository.dart';
// import 'package:complaint_portal/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/database_provider.dart';
import '../utils/validators.dart';
import '../widgets/clipper.dart';
import '../widgets/text_form_field_item.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    color: const Color(0xFF181D3D),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 16),
                        Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.apply(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  void formProcessor() async {
    try {
      UserRepository().createUser(
        _emailController.text,
        _nameController.text,
        _rollNumberController.text,
        _roomNoController.text,
      );
    } catch (e) {
      print(e);
    }
  }

  late String hostelName = "Select";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roomNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _nameController.text = user.displayName!;
    _emailController.text = user.email!;
  }

  void setProfile() {
    UserRepository().updateUser(
      user.uid,
      _rollNumberController.text,
      _phoneNumberController.text,
      hostelName,
      _roomNoController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormFieldItem(
            labelText: 'Name',
            canEdit: false,
            controller: _nameController,
          ),
          const SizedBox(height: 20),
          TextFormFieldItem(
            controller: _emailController,
            labelText: 'Email',
            canEdit: false,
            validator: (input) =>
                !isEmail(input!) ? 'Enter a valid email' : null,
          ),
          const SizedBox(height: 20),
          TextFormFieldItem(
            controller: _rollNumberController,
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
            controller: _phoneNumberController,
            labelText: 'PhoneNumber',
            validator: (String? value) {
              return isPhoneNumber(value!);
            },
          ),
          const SizedBox(height: 20),
          TextFormFieldItem(
            controller: _passwordController,
            labelText: 'Password',
            validator: (String? value) {
              return isPassword(value!);
            },
          ),
          const SizedBox(height: 20),
          TextFormFieldItem(
            controller: _roomNoController,
            labelText: 'Room No.',
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your room no.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: dropDownMenu(context),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setProfile();
              }
            },
          ),
        ]),
      ),
    );
    //     },
    //   );
  }

  DropdownButtonHideUnderline dropDownMenu(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          hint: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Text(
              'Hostel',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 16),
            ),
          ),
          value: hostelName,
          onChanged: (String? value) {
            setState(() {
              hostelName = value!;
            });
          },
          isExpanded: true,
          style: Theme.of(context).textTheme.bodyLarge,
          items: <String>["Select", ...hostels].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 16),
                ),
              ),
            );
          }).toList()),
    );
  }
}
