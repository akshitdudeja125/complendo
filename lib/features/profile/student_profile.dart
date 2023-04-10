import 'package:complaint_portal/features/auth/repository/user_repository.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popup_banner/popup_banner.dart';

class StudentProfile extends ConsumerStatefulWidget {
  // final Map<String, dynamic> userData;
  final UserModel user;
  const StudentProfile({
    super.key,
    required this.user,
    // required this.userData,
  });

  @override
  ConsumerState<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends ConsumerState<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    // precacheImage(NetworkImage(user.photoURL!), context);x
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              ListTile(
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              if (widget.user.photoURL != null)
                InkWell(
                  onTap: () {
                    showDefaultPopup(
                        context: context, images: [widget.user.photoURL!]);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      widget.user.photoURL!,
                    ),
                  ),
                ),
              Text(
                widget.user.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                widget.user.rollNo!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const ListTile(
                title: Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  // userData['name'],
                  widget.user.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ListTile(
                title: const Text(
                  "Roll No.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.user.rollNo!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ListTile(
                title: const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.user.email,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ListTile(
                title: const Text(
                  "Phone No.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.user.phoneNumber!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: IconButton(
                  onPressed: () {
                    final TextEditingController controller =
                        TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) => alertDialog(
                        title: "Change Phone Number",
                        controller: controller,
                        hintText: "Enter new phone number",
                        onSubmit: () {
                          // update phone number
                          // Check if phone number is valid
                          // if valid then update
                          // else show error
                          if (controller.text.length != 10) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid Phone Number"),
                              ),
                            );
                            return;
                          }
                          UserRepository()
                              .updateUserField(
                            widget.user.id,
                            'phoneNumber',
                            controller.text,
                          )
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Phone Number Updated"),
                              ),
                            );
                            //refresh the user data
                          });

                          // update phone number
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text("Phone Number Updated"),
                          //   ),
                          // );
                          //
                          Navigator.pop(context);
                        },
                        // "Change Phone Number",
                        // controller,
                        // "Enter new phone number",
                        // ()
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                title: const Text(
                  "Hostel",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.user.hostel!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ListTile(
                title: const Text(
                  "Room Number",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.user.roomNo!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// image in full screen
// Path: lib/features/profile/student_profile.dart

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  const DetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: Image.network(
            imageUrl,
          ),
        ),
      ),
    );
  }
}

AlertDialog alertDialog({
  required String title,
  required TextEditingController controller,
  String? hintText,
  Function()? onSubmit,
}) =>
    AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter new phone number",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text("Change"),
          ),
        ],
      ),
    );

void showDefaultPopup({
  required BuildContext context,
  required List<String> images,
}) {
  PopupBanner(
    fit: BoxFit.contain,
    fromNetwork: true,
    context: context,
    images: images,
    onClick: (index) {
      debugPrint("CLICKED $index");
    },
  ).show();
}
