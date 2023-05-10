// ignore_for_file: unnecessary_const, deprecated_member_use

import 'package:complaint_portal/common/services/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';

final isTermsCheckedProvider = StateProvider<bool>((ref) => false);

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Welcome to Complendo",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 9,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Image(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: size.height / 18,
              ),
              const Text(
                "Complendo is a platform for students to raise complaints and grievances",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  // color: Colors.orange,
                ),
              ),
              const SizedBox(
                height: kDefaultSpacing,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: 'Read our ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showModalBottomSheet(
                              constraints: const BoxConstraints(
                                maxHeight: 500,
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Privacy Policy",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ...terms.map((term) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              term,
                                              // textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        const Text(
                                          "Contact Us",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Name: $devName",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: "Email: ",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Color.fromARGB(
                                                      255, 6, 44, 235),
                                                ),
                                                text: "dudejaakshit@gmail.com",
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        URLLauncher.sendEmail(
                                                          email: devEmail,
                                                          subject: "Complendo",
                                                          body: "Hello",
                                                        );
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: "Phone: ",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Color.fromARGB(
                                                      255, 6, 44, 235),
                                                ),
                                                text: "+919643798169",
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        URLLauncher.callNumber(
                                                          number: devPhone,
                                                        );
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 6, 44, 235),
                        ),
                      ),
                      const TextSpan(
                        text:
                            '. Tap Agree and Continue to accept the Terms of Service',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: kDefaultSpacing,
              ),
              Consumer(builder: (context, ref, child) {
                return CustomElevatedButton(
                  text: "AGREE AND CONTINUE",
                  onClick: () => {
                    ref.read(isTermsCheckedProvider.notifier).state = true,
                  },
                  bgColor: kPrimaryColor,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
