import 'package:complaint_portal/common/services/connectivity_service.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:complaint_portal/features/auth/features/register/provider/register_form_providers.dart';
import 'package:complaint_portal/features/auth/providers/auth_provider.dart';
import 'package:complaint_portal/features/auth/repository/user_repository.dart';
import 'package:complaint_portal/models/user_model.dart';

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
    final userRepo = ref.read(userRepositoryProvider);
    await userRepo.setUser(
      UserModel(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        photoURL: user.photoURL,
        hostel: ref.watch(hostelProvider),
        roomNo: ref.watch(roomNoProvider),
        phoneNumber: ref.watch(phoneNoProvider),
        rollNo: ref.watch(rollNoProvider),
        isAdmin: false,
      ),
    );
    displaySnackBar('Success', 'User Registered Successfully');
  } catch (e) {
    displaySnackBar('Error', 'Something went wrong');
  }
  ref.watch(isLoadingProvider.notifier).state = false;
}
