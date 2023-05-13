import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/utils/extensions.dart';
import 'package:complaint_portal/common/widgets/custom_app_bar.dart';
import 'package:complaint_portal/common/widgets/dropdown_dialog.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/auth/repository/user_repository.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'image_detail_screen.dart';

class EditProfile extends ConsumerStatefulWidget {
  final UserModel user;
  const EditProfile({
    required this.user,
    super.key,
  });

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  late TextEditingController _rollController;
  late TextEditingController _roomNoController;
  Hostel? hostel;
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _rollController = TextEditingController(text: widget.user.rollNo);
    _roomNoController = TextEditingController(text: widget.user.roomNo);
    hostel = widget.user.hostel;
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      appBar: CustomAppBar(
        heading: "Edit Profile",
        trailing: IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final updatedUser = user.copyWith(
                  phoneNumber: _phoneController.text,
                  rollNo: _rollController.text,
                  hostel: hostel,
                  roomNo: _roomNoController.text,
                );
                final userRepo = ref.read(userRepositoryProvider);
                userRepo.setUser(updatedUser);
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.done,
              color: Theme.of(context).iconTheme.color,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (user.photoURL != null)
                  InkWell(
                    onTap: () {
                      showDefaultPopup(
                          context: context, images: [user.photoURL!]);
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        user.photoURL!,
                      ),
                    ),
                  ),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  user.userType!.value.capitalize(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
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
                      TextFormFieldItem(
                        controller: _rollController,
                        labelText: 'Roll No.',
                        canEdit: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormFieldItem(
                        controller: _phoneController,
                        labelText: 'Phone Number',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormFieldItem(
                        labelText: 'Hostel',
                        controller: TextEditingController(
                          text: hostel.toString(),
                        ),
                        enabled: true,
                        suffixIcon: FeatherIcons.chevronDown,
                        canEdit: false,
                        onSuffixTap: () async {
                          final selected = await showDropDownDialog(
                            title: 'Select Hostel',
                            items: Hostel.getHostels(),
                          );
                          if (selected != null) {
                            setState(() {
                              hostel = Hostel.values.firstWhere(
                                  (element) => element.toString() == selected);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormFieldItem(
                        controller: _roomNoController,
                        labelText: 'Room No.',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:complaint_portal/common/utils/enums.dart';
// import 'package:complaint_portal/common/utils/extensions.dart';
// import 'package:complaint_portal/common/widgets/custom_app_bar.dart';
// import 'package:complaint_portal/common/widgets/dropdown_dialog.dart';
// import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
// import 'package:complaint_portal/features/auth/providers/user_provider.dart';
// import 'package:complaint_portal/features/auth/repository/user_repository.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'image_detail_screen.dart';

// class EditProfile extends ConsumerStatefulWidget {
//   final UserModel user;
//   const EditProfile({
//     required this.user,
//     super.key,
//   });

//   @override
//   ConsumerState<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends ConsumerState<EditProfile> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _phoneController;
//   late TextEditingController _rollController;
//   late TextEditingController _roomNoController;
//   late final user = ref.read(userProvider);
//   Hostel? hostel;
//   @override
//   void initState() {
//     super.initState();
//     final user = ref.read(userProvider);
//     _phoneController = TextEditingController(text: user.phoneNumber);
//     _rollController = TextEditingController(text: user.rollNo);
//     _roomNoController = TextEditingController(text: user.roomNo);
//     hostel = user.hostel;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         heading: "Edit Profile",
//         trailing: IconButton(
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 final updatedUser = user.copyWith(
//                   phoneNumber: _phoneController.text,
//                   rollNo: _rollController.text,
//                   hostel: hostel,
//                   roomNo: _roomNoController.text,
//                 );
//                 final userRepo = ref.read(userRepositoryProvider);
//                 userRepo.setUser(updatedUser);
//                 Navigator.pop(context);
//               }
//             },
//             icon: Icon(
//               Icons.done,
//               color: Theme.of(context).iconTheme.color,
//             )),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 2),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 if (user.photoURL != null)
//                   InkWell(
//                     onTap: () {
//                       showDefaultPopup(
//                           context: context, images: [user.photoURL!]);
//                     },
//                     child: CircleAvatar(
//                       radius: 40,
//                       backgroundImage: NetworkImage(
//                         user.photoURL!,
//                       ),
//                     ),
//                   ),
//                 Text(
//                   user.name,
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 Text(
//                   user.userType!.value.capitalize(),
//                   style: Theme.of(context).textTheme.titleSmall,
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.04,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: Column(
//                     children: [
//                       const ListTile(
//                         title: Text(
//                           "Personal Information",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                       TextFormFieldItem(
//                         controller: TextEditingController(
//                           text: user.id,
//                         ),
//                         labelText: 'ID',
//                         canEdit: false,
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                       TextFormFieldItem(
//                         controller: TextEditingController(
//                           text: user.email,
//                         ),
//                         labelText: 'Email',
//                         canEdit: false,
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                       TextFormFieldItem(
//                         controller: _rollController,
//                         labelText: 'Roll No.',
//                         canEdit: false,
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                       TextFormFieldItem(
//                         controller: _phoneController,
//                         labelText: 'Phone Number',
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                       TextFormFieldItem(
//                         labelText: 'Hostel',
//                         controller: TextEditingController(
//                           text: hostel.toString(),
//                         ),
//                         enabled: true,
//                         suffixIcon: FeatherIcons.chevronDown,
//                         canEdit: false,
//                         onSuffixTap: () async {
//                           final selected = await showDropDownDialog(
//                             title: 'Select Hostel',
//                             items: Hostel.getHostels(),
//                           );
//                           if (selected != null) {
//                             setState(() {
//                               hostel = Hostel.values.firstWhere(
//                                   (element) => element.toString() == selected);
//                             });
//                           }
//                         },
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                       TextFormFieldItem(
//                         controller: _roomNoController,
//                         labelText: 'Room No.',
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
