import 'package:complaint_portal/features/services/connectivity_service.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:complaint_portal/providers/complaint_form_provider.dart';
import 'package:complaint_portal/providers/complaint_provider.dart';
import 'package:complaint_portal/providers/firebase_instance_provider.dart';
import 'package:complaint_portal/providers/user_provider.dart';
import 'package:complaint_portal/providers/page_controller_provider.dart';
import 'package:complaint_portal/common/widgets/display_snack_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void submitComplaint(ref) async {
  if (ref.watch(hostelProvider.notifier).state == null) {
    displaySnackBar('Error', 'Please select a hostel');
    return;
  }
  if (ref.watch(complaintCategoryProvider.notifier).state == null) {
    displaySnackBar('Error', 'Please select a complaint category');
    return;
  }
  if (!ref.watch(formKeyProvider.notifier).state.currentState!.validate()) {
    displaySnackBar('Error', 'Please fill all the fields');
    return;
  }

  if (!await checkConnectivity(ref)) return;

  try {
    ref.watch(isLoadingProvider.notifier).state = true;
    displaySnackBar('Details Verified', 'Processing Data');
    final firestore = ref.watch(firebaseFirestoreProvider);
    final complaintId = firestore.collection('complaints').doc().id;
    String? downloadURL = await ref
        .watch(firebaseStorageRepositoryProvider)
        .getDownloadURL(ref, complaintId, ref.watch(pickedImageProvider));

    final Complaint complaint = Complaint(
      uid: ref.watch(authUserProvider).uid,
      cid: complaintId,
      title: ref.watch(titleProvider),
      description: ref.watch(descriptionProvider),
      category: ref.watch(complaintCategoryProvider),
      status: 'Pending',
      isIndividual: ref.watch(complaintTypeProvider) == 'Common' ? false : true,
      complaintType: ref.watch(complaintTypeProvider),
      date: DateTime.now(),
      imageLink: downloadURL,
    );

    await ref
        .watch(complaintRepositoryProvider)
        .registerComplaint(ref, complaint);

    await FirebaseAnalytics.instance.logEvent(name: 'complaint_submitted');
    await displaySnackBar('Success', 'Complaint submitted successfully');
    await ref.watch(onPageChangeProvider).call(0);
    clearForm(ref);
  } catch (error) {
    displaySnackBar('Error', '$error');
  }

  ref.watch(isLoadingProvider.notifier).state = false;
}
