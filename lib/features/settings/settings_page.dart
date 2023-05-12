import 'package:complaint_portal/common/theme/theme_provider.dart';
import 'package:complaint_portal/common/utils/constants.dart';
// import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/widgets/dialog.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/profile/profile.dart';
import 'package:complaint_portal/features/settings/about_page.dart';
import 'package:complaint_portal/features/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final switchProvider = StateProvider<bool>((ref) => false);

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final user = ref.watch(userProvider);
        final isDark = ref.watch(isDarkProvider);
        // print("user: $user");
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        ref.watch(isDarkProvider.notifier).state = !isDark;
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isDark', isDark);
                      },
                      icon: Icon(
                        Icons.light,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await ref.read(authRepositoryProvider).signOut(ref);
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
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
                              user.userType!.value.capitalize!,
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
                          subtitle: "View/Edit your profile",
                          iconData: Icons.person,
                          onTap: () {
                            Get.to(
                              const Profile(),
                            );
                          },
                        ),
                        SettingsTile(
                          title: "Dark Mode",
                          subtitle: "Turn on/off dark mode",
                          iconData: Icons.dark_mode,
                          trailing: Switch(
                            activeColor: kPrimaryColor,
                            value: ref.watch(isDarkProvider),
                            onChanged: (value) async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isDark', value);
                              ref.watch(isDarkProvider.notifier).state = value;
                            },
                          ),
                        ),
                        // SettingsTile(
                        //   title: "Notifications",
                        //   subtitle: "Turn on/off notifications",
                        //   icon: const Icon(Icons.notifications),
                        //   onTap: () {
                        //     //set user notif in firebase
                        //   },
                        // ),
                        // SettingsTile(
                        //   title: "Change Password",
                        //   subtitle: "Change your password",
                        //   icon: const Icon(Icons.lock),
                        //   onTap: () {
                        //     // show Get Dialog
                        //   },
                        // ),
                        SettingsTile(
                          title: "About",
                          subtitle: "About the app",
                          iconData: Icons.info,
                          onTap: () {
                            Get.to(
                              const AboutPage(),
                            );
                          },
                        ),
                        SettingsTile(
                          title: "Logout",
                          iconData: Icons.logout,
                          onTap: () async {
                            final bool? dResult = await dialogResult(
                                'Logout', 'Are you sure you want to logout?');
                            if (dResult == true) {
                              final result = await ref
                                  .read(authRepositoryProvider)
                                  .signOut(ref);
                              if (result) {
                                displaySnackBar(
                                    'Success', 'Logged out successfully');
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Center(
                          child: Column(
                            children: const [
                              Text(
                                "Version 1.0.0",
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
