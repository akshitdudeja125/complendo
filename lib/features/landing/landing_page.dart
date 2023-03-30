import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isTermsCheckedProvider = StateProvider<bool>((ref) => false);

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                "Welcome to Complendo",
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor),
              ),
            ),
            SizedBox(
              height: size.height / 9,
            ),
            // SvgPicture.asset(
            // "assets/icons/whisper4a.svg",
            // color: AppColors.primaryColor,
            // height: 340,
            // width: 340,
            // ),
            SizedBox(
              height: size.height / 18,
            ),
            const Text(
              "Complendo is a platform for students to raise complaints and grievances",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
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
                      onEnter: (event) {
                        displaySnackBar("Terms of Service", "Tapped");
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
              height: 10,
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
    );
  }
}
