import 'package:complaint_portal/providers/auth_provider.dart';
import 'package:complaint_portal/providers/database_provider.dart';
import 'package:complaint_portal/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constants.dart';
import '../../services/auth_service.dart';

class StudentProfile extends ConsumerStatefulWidget {
  const StudentProfile({super.key});

  @override
  ConsumerState<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends ConsumerState<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    final userDataState = ref.watch(currentUserDataProvider);
    return userDataState.when(
      error: (e, trace) => ErrorScreen(e, trace),
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      data: (data) {
        if (data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            if (data['photoURL'] != null)
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  data['photoURL'],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: defaultSpacing / 2),
              child: Text(
                data['name'],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: defaultSpacing / 2),
              child: Text(
                data['rollNo'],
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            GestureDetector(
              onTap: () => AuthService().signOut(ref),
              child: const Chip(
                label: Text("Log out"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
