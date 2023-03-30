import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/features/auth/features/register/provider/register_form_providers.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/services/connectivity_service.dart';
import 'package:complaint_portal/features/services/user_repository.dart';

void setProfile(ref) async {
  if (ref.watch(hostelProvider.notifier).state == null) {
    displaySnackBar('Error', 'Please select a hostel');
    return;
  }
  if (!ref.watch(formKeyProvider.notifier).state.currentState!.validate()) {
    displaySnackBar('Error', 'Please fill all the fields');
    return;
  }
  ref.watch(isLoadingProvider.notifier).state = true;

  if (!await checkConnectivity(ref)) return;

  try {
    final user = ref.watch(authUserProvider);
    final userRepo = ref.read(userRepoProvider);
    await userRepo.setUser(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
      hostel: ref.watch(hostelProvider),
      roomNo: ref.watch(roomNoProvider),
      phoneNumber: ref.watch(phoneNoProvider),
      rollNo: ref.watch(rollNoProvider),
      ref: ref,
    );
    displaySnackBar('Success', 'User Registered Successfully');
  } catch (e) {
    displaySnackBar('Error', 'Something went wrong');
  }
  ref.watch(isLoadingProvider.notifier).state = false;
}
