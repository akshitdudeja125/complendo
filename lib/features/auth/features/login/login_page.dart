// ignore_for_file: unused_field, unused_local_variable, unused_element

import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/clipper.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                          'Login',
                          style:
                              Theme.of(context).textTheme.headlineSmall?.apply(
                                    color: Colors.white,
                                  ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                child: const Text("  Logging in...")),
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormFieldItem(
              controller: _emailController,
              labelText: 'Email',
              validator: (input) =>
                  !isEmail(input!) ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: 20),
            TextFormFieldItem(
              controller: _passwordController,
              labelText: 'Password',
              validator: (input) =>
                  !isPassword(input!) ? 'Enter a valid password' : null,
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
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Processing Data'),
                    ),
                  );
                  _showDialog(context);
                  // _createAccount();
                }
              },
            ),
            const SizedBox(height: 20),
            GoogleSignInButton(
              context: context,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends ConsumerWidget {
  final BuildContext context;
  const GoogleSignInButton({super.key, required this.context});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/google.png',
            height: 20,
          ),
          const SizedBox(width: 10),
          Text(
            'Sign in with Google',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.apply(color: Colors.black),
          ),
        ],
      ),
      onPressed: () async {
        ref.read(authRepositoryProvider).signInWithGoogle();
      },
    );
  }
}
