import 'package:complaint_portal/features/complaint/screen/form/complaint_form.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';

class ComposeComplaint extends StatelessWidget {
  // final Map<String, dynamic> userData;
  final UserModel user;
  const ComposeComplaint({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ComplaintForm(
                  // userData: userData,
                  user: user,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
