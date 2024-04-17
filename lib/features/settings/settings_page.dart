import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/theme/theme_provider.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/dialog.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/auth/repository/user_repository.dart';
import 'package:complaint_portal/features/manage_users/manage_user_screen.dart';
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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Settings',
                  style:
                      TextStyles(Theme.of(context).brightness).appbarTextStyle,
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
                        color: ThemeColors
                            .settingsIconColor[Theme.of(context).brightness],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await ref.read(authRepositoryProvider).signOut(ref);
                      },
                      icon: Icon(
                        Icons.logout,
                        color: ThemeColors
                            .settingsIconColor[Theme.of(context).brightness],
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
                              style: TextStyles(Theme.of(context).brightness)
                                  .settingsTitleTextStyle2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: kDefaultSpacing / 2),
                            child: Text(
                              user.userType!.value.capitalize!,
                              style: TextStyles(Theme.of(context).brightness)
                                  .settingsSubtitleTextStyle2,
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
                        if (user.userType!.value == 'admin' ||
                            user.userType!.value == 'warden')
                          SettingsTile(
                            title: "Users",
                            subtitle: "Manage users",
                            iconData: Icons.people,
                            onTap: () {
                              Get.to(
                                const ManageUsers(),
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
                        SettingsTile(
                          title: "Notifications",
                          subtitle: "Turn on/off notifications",
                          iconData: Icons.notifications,
                          trailing: Switch(
                            activeColor: kPrimaryColor,
                            value: user.notifications ?? true,
                            onChanged: (value) async {
                              ref.watch(userRepositoryProvider).updateUserField(
                                    user.id,
                                    'notifications',
                                    value,
                                  );
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
                        // SettingsTile(
                        //   title: "About",
                        //   subtitle: "About the app",
                        //   iconData: Icons.info,
                        //   onTap: () {
                        //     Get.to(
                        //       const AboutPage(),
                        //     );
                        //   },
                        // ),
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
                        // Center(
                        //   child: Column(
                        //     children: const [
                        //       Text(
                        //         "Version 1.0.0",
                        //       ),
                        //       Text(
                        //         "Made with ❤️ by Akshit",
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
