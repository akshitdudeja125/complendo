import 'package:complaint_portal/features/complaint/screens/compose/complaint_form.dart';
import 'package:flutter/material.dart';

class ComposeComplaint extends StatelessWidget {
  const ComposeComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('compose_complaint_screen'),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: const Text(
                      "Compose Complaint",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Info"),
                          content: const Text(
                            '''All the fields are mandatory to fill.\n\nIf you are facing any issue, please contact the admin.''',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.info,
                        color: Theme.of(context).iconTheme.color,
                        size: 30,
                      ),
                    )),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: ComplaintForm(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:complaint_portal/features/complaint/screen/form/complaint_form.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';

// class ComposeComplaint extends StatelessWidget {
//   // final Map<String, dynamic> userData;
//   final UserModel user;
//   const ComposeComplaint({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListTile(
//                         title: const Text(
//                           "Compose Complaint",
//                           style: TextStyle(
//                             fontSize: 23,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         trailing: InkWell(
//                           onTap: () => showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               title: const Text("Info"),
//                               content: const Text(
//                                 '''All the fields are mandatory to fill.\n\nIf you are facing any issue, please contact the admin.''',
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text("OK"),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           child: const Icon(
//                             Icons.info,
//                             size: 30,
//                           ),
//                         )),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: ComplaintForm(
//                       user: user,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
