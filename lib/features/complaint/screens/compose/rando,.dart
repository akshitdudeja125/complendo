import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/providers/complaint_form_provider.dart';
import 'package:complaint_portal/features/complaint/screens/compose/sections/complaint_section.dart';
import 'package:complaint_portal/features/complaint/screens/compose/sections/user_data_section.dart';
import 'package:complaint_portal/features/complaint/widgets/submit_complaint_form.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/widgets/custom_elevated_button.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplaintForm extends ConsumerWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('ComplaintForm');
    final isLoading = ref.watch(isLoadingProvider);
    return Stack(
      children: [
        if (isLoading) const Center(child: CircularProgressIndicator()),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Consumer(builder: (context, ref, _) {
                final UserModel user = ref.watch(userProvider);
                return Form(
                  key: ref.watch(formKeyProvider),
                  child: Column(
                    children: [
                      UserDataSection(user: user),
                      SizedBox(height: kFormSpacing),
                      Consumer(builder: (context, ref, _) {
                        //RECALL when one time  the form is submitted
                        //and then the user goes back to the form
                        //the form is not reset

                        if (ref.watch(hostelProvider) == null) {
                          return const ComplaintSection();
                        }
                        return const ComplaintSection();
                      }),
                      SizedBox(height: kFormSpacing),
                      SubmitButton(
                        isLoadingProvider: isLoadingProvider,
                        onClick: () {
                          submitComplaint(ref, user);
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
    // },
    // );
  }
}