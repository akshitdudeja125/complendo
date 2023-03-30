import 'package:complaint_portal/providers/user_provider.dart';
import 'package:complaint_portal/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/constants.dart';
import '../auth/repository/auth_repository.dart';

class StudentProfile extends ConsumerWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authUserProvider);
    final data = ref.watch(userDataStreamProvider(authUser!.uid));
    return data.when(
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
