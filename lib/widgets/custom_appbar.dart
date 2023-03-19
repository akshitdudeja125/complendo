// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final avatarImage;
  const TopBar({super.key, this.avatarImage});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(32, 33, 36, 1),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          GestureDetector(
            onTap: () async {},
            child: Container(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarImage ??
                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
