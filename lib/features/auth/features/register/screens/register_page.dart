import 'package:complaint_portal/common/widgets/clipper.dart';
import 'package:complaint_portal/features/auth/features/register/forms/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
