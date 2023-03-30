import 'package:complaint_portal/features/complaint/screen/form/complaint_form.dart';
import 'package:flutter/material.dart';

class ComposeComplaint extends StatelessWidget {
  const ComposeComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ComplaintForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
