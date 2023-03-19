import 'package:complaint_portal/constants.dart';
import 'package:complaint_portal/screens/home_screen.dart';
import 'package:complaint_portal/services/user_repository.dart';
// import 'package:complaint_portal/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/clipper.dart';
import '../widgets/text_form_field_item.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  void formProcessor() async {
    try {
      UserRepository().createUser(
        user,
        _nameController.text,
        _rollNumberController.text,
        _roomNoController.text,
      );
    } finally {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
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
  void _showDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF181D3D)),
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("  Registering...")),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _nameController.text = user.displayName!;
    _emailController.text = user.email!;
  }

  void _createAccount() async {
    // _showDialog(context);
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Establishing Contact with the Server')));
      _showDialog(context);
      // loadingDialogue(context);
      var e = UserRepository().createUser(
        user,
        _nameController.text,
        _rollNumberController.text,
        _roomNoController.text,
      );
      // var db = FirebaseFirestore.instance.collection('users');
      // await db.doc(user.uid).set({
      //   'name': _nameController.text,
      //   'uid': user.uid,
      //   'isAdmin': false,
      //   'email': user.email,
      //   'hostel': hostelName,
      //   'rollNo': _rollNumberController.text,
      //   'roomNo': _roomNoController.text,
      //   'type': 'student',
      //   'category': "general",
      //   'profilePic': user.photoURL,
      //   'complaintList': []
      // }).then(
      //   (value) => Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(
      //       builder: (context) => const HomePage(),
      //     ),
      //   ),
      // );
      if (e != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account Created Successfully')));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account Creation Failed')));
      }
    }
  }

  // void _showDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: Colors.white,
  //       ),
  //       child: Row(
  //         children: [
  //           const CircularProgressIndicator(
  //             valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF181D3D)),
  //           ),
  //           Container(
  //               margin: const EdgeInsets.only(left: 7),
  //               child: const Text("  Registering...")),
  //         ],
  //       ),
  //     ),
  //   );
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return alert;
  //       });
  // }

  // void _createAccount() {}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormFieldItem(
            controller: _nameController,
            labelText: 'Name',
            validator: (String? value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormFieldItem(
            controller: _emailController,
            labelText: 'Email',
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
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }

              return null;
            },
          ),
          TextFormFieldItem(
            controller: _passwordController,
            labelText: 'Password',
            validator: (String? value) {
              return isPassword(value!)
                  ? null
                  : 'Password must be at least 8 characters long';
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
            child: DropdownButtonHideUnderline(
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
            ),
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
                // print('Validated');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Processing Data'),
                  ),
                );
                _createAccount();
              }
            },
          ),
        ]),
      ),
    );
  }
}
