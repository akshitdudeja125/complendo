import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal/common/services/notifications/push_notifications.dart';
import 'package:complaint_portal/common/theme/theme_provider.dart';
import 'package:complaint_portal/features/auth/repository/user_repository.dart';

import 'package:complaint_portal/features/profile/student_profile.dart';
import 'package:complaint_portal/features/settings/about_page.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/constants.dart';
import '../auth/repository/auth_repository.dart';

final switchProvider = StateProvider<bool>((ref) => false);

class SettingsPage extends StatelessWidget {
  final UserModel user;
  const SettingsPage({
    super.key,
    required this.user,
    // required this.userData,
  });
  @override
  Widget build(BuildContext context) {
    // Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Consumer(
                builder: (context, ref, child) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.watch(isDarkProvider.notifier).state =
                            !ref.watch(isDarkProvider);
                      },
                      icon: const Icon(Icons.light),
                    ),
                    IconButton(
                      onPressed: () => AuthService().signOut(context),
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        user.photoURL != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(user.photoURL!),
                              )
                            : const CircleAvatar(
                                radius: 50,
                              ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultSpacing / 2),
                          child: Text(
                            user.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: kDefaultSpacing / 2),
                          child: Text(
                            user.rollNo ?? "Roll No",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SettingsTile(
                        title: "Profile",
                        subtitle: "Edit your profile",
                        icon: const Icon(Icons.person),
                        onTap: () {
                          Get.to(
                            StudentProfile(
                              user: user,
                            ),
                          );
                        },
                      ),
                      Consumer(
                        builder: (context, ref, _) => SettingsTile(
                          title: "Dark Mode",
                          subtitle: "Turn on/off dark mode",
                          icon: const Icon(Icons.dark_mode),
                          trailing: Switch(
                            activeColor: kPrimaryColor,
                            // value: ThemeController.of(context).isDark,
                            value: ref.watch(isDarkProvider),
                            onChanged: (value) async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isDark', value);
                              print("Prefs ->  ${prefs.getBool("isDark")}");
                              print(prefs.getBool('isDark'));
                              ref.watch(isDarkProvider.notifier).state = value;
                            },
                          ),
                          onTap: () {
                            ref.watch(isDarkProvider.notifier).state =
                                !ref.watch(isDarkProvider);
                          },
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, _) => SettingsTile(
                          title: "Notifications",
                          subtitle: "Turn on/off notifications",
                          icon: const Icon(Icons.notifications),
                          onTap: () {},
                          // trailing: Switch(
                          //   activeColor: kPrimaryColor,
                          //   // value: ref.watch(switchProvider),
                          //   value: user.notifications ?? true,
                          //   onChanged: (value) {
                          //     // ref.read(switchProvider.notifier).state = value;
                          //     ref.read(userRepositoryProvider).updateUserField(
                          //           user.id,
                          //           'notifications',
                          //           value,
                          //         );
                          //     UserRepository().updateUserField(
                          //       user.id,
                          //       'notifications',
                          //       value,
                          //     );
                          //   },
                          // ),
                          // onTap: () {
                          //   ref.read(switchProvider.notifier).state =
                          //       !ref.watch(switchProvider);
                          // },
                        ),
                      ),
                      SettingsTile(
                        title: "Change Password",
                        subtitle: "Change your password",
                        icon: const Icon(Icons.lock),
                        onTap: () {
                          // show Get Dialog
                        },
                      ),
                      SettingsTile(
                        title: "About",
                        subtitle: "About the app",
                        icon: const Icon(Icons.info),
                        onTap: () {
                          Get.to(
                            const AboutPage(),
                          );
                        },
                      ),
                      Consumer(
                        builder: (context, ref, _) => SettingsTile(
                          title: "Logout",
                          icon: const Icon(Icons.logout),
                          onTap: () => AuthService().signOut(ref),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Center(
                        child: Column(
                          children: const [
                            Text(
                              "Version 1.0.0",
                              // s
                            ),
                            Text(
                              "Made with ❤️ by Akshit",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      // Container(
                      //   color: Colors.yellow[200],
                      //   height: 400,
                      //   width: 400,
                      //   // alignment: Alignment(1, 1),
                      //   // child: Positioned(
                      //   //   width: 200,
                      //   //   height: 200,
                      //   //   bottom: 0,
                      //   //   right: 0,
                      //   //   child: Container(
                      //   //       color: Colors.red[200],
                      //   //       ),
                      //   //   // color: Colors.red[200],
                      //   // ),
                      // ),
                      Center(
                        child: Container(
                          color: Colors.yellow[200],
                          height: 300,
                          width: 300,
                          child: Stack(
                            children: [
                              Positioned(
                                width: 100,
                                height: 100,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.red[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
//create a text Account in the start of the page
          // const Padding(
          //   padding: EdgeInsets.only(left: 20.0),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       "Account",
          //       style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.grey[200],
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: ListTile(
          //       leading: CircleAvatar(
          //         backgroundImage: NetworkImage(user.photoURL ?? ""),
          //       ),
          //       title: Text(user.name),
          //       subtitle: Text(user.email),
          //       trailing: IconButton(
          //         onPressed: () {},
          //         // icon: const Icon(),
          //         // load icon from assets
          //         icon: Image.asset(
          //           "assets/images/edit.png",
          //           width: 20,
          //           height: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          // // if (userData['photoURL'] != null)
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  String? imageUrl;
  String? subtitle;
  Icon? icon;
  IconData? trailingIcon;
  final VoidCallback? onTap;
  Widget? trailing;
  SettingsTile({
    super.key,
    required this.title,
    this.subtitle = "",
    this.imageUrl,
    this.icon,
    this.onTap,
    this.trailing,
    this.trailingIcon = Icons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Padding(
            padding: subtitle == ""
                ? const EdgeInsets.symmetric(horizontal: 8)
                : const EdgeInsets.all(8),
            child: imageUrl == null
                ? icon
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  )),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle ?? "",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black54,
              ),
        ),
        trailing: trailing ??
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultSpacing),
              child: Icon(
                trailingIcon,
                size: 20,
                color: Colors.black26,
              ),
            ),
      ),
    );
  }
}
