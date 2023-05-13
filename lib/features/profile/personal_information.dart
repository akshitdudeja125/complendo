import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';

class PersonalImformation extends StatelessWidget {
  const PersonalImformation({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        TextFormFieldItem(
          controller: TextEditingController(
            text: user.id,
          ),
          labelText: 'ID',
          canEdit: false,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        TextFormFieldItem(
          controller: TextEditingController(
            text: user.email,
          ),
          labelText: 'Email',
          canEdit: false,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        //for phone number
        if (user.userType == UserType.student)
          TextFormFieldItem(
            controller: TextEditingController(
              text: user.rollNo,
            ),
            labelText: 'Roll No.',
            canEdit: false,
          ),
        if (user.userType == UserType.student)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        TextFormFieldItem(
          controller: TextEditingController(
            text: user.phoneNumber,
          ),
          labelText: 'Phone Number',
          canEdit: false,
        ),
        if (user.userType == UserType.student ||
            user.userType == UserType.warden)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        if (user.userType == UserType.student ||
            user.userType == UserType.warden)
          TextFormFieldItem(
            controller: TextEditingController(
              // text: user.hostel,
              text: user.hostel.toString(),
            ),
            labelText: 'Hostel',
            canEdit: false,
          ),
        if (user.userType == UserType.student)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        if (user.userType == UserType.student)
          TextFormFieldItem(
            controller: TextEditingController(
              text: user.roomNo ?? '',
            ),
            labelText: 'Room No.',
            canEdit: false,
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
      ],
    );
  }
}
