import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomeScreenTopSection extends StatelessWidget {
  const HomeScreenTopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final user = ref.watch(userProvider);
      return ListTile(
        // title: Text(
        //   "Welcome ${user.name.split(" ")[0].capitalizeFirst} ",
        //   style: const TextStyle(
        //     fontSize: 23,
        //     fontWeight: FontWeight.w900,
        //   ),
        // ),
        title: Text(
          "Complendo ",
          style: TextStyle(
            fontSize: 32,
            // color: Color.fromARGB(255, 6, 56, 97),
            // color: Theme.of(context).brightness == Brightness.light
            //     ? const Color.fromARGB(255, 6, 56, 97)
            //         .withOpacity(0.8)
            //     : const Color.fromARGB(255, 101, 185, 253)
            //         .withOpacity(0.8),
            color: ThemeColors.homePageFontColor[Theme.of(context).brightness],
            fontWeight: FontWeight.w700,
          ),
        ),
        // subtitle: Text(
        //   " Hi, ${user.name.split(" ")[0].capitalizeFirst} ",
        //   style: const TextStyle(
        //     fontSize: 23,
        //     color: Color.fromARGB(255, 6, 56, 97),
        //     fontWeight: FontWeight.w900,
        //   ),
        // ),
        // displau hi small and name bold
        subtitle: Text.rich(
          TextSpan(
            text: " Hi, ",
            style: TextStyle(
              fontSize: 23,
              // color: Color.fromARGB(255, 6, 56, 97),
              // color:
              //     Theme.of(context).brightness == Brightness.light
              //         ? const Color.fromARGB(255, 6, 56, 97)
              //             .withOpacity(0.8)
              //         : const Color.fromARGB(255, 101, 185, 253)
              //             .withOpacity(0.8),
              color:
                  ThemeColors.homePageFontColor[Theme.of(context).brightness],
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: "${user.name.split(" ")[0].capitalizeFirst}",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: ThemeColors
                      .homePageFontColor[Theme.of(context).brightness],
                ),
              ),
            ],
          ),
        ),
        trailing: InkWell(
          onTap: () {
            Get.to(
              () => const Profile(),
            );
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
        ),
      );
    });
  }
}
