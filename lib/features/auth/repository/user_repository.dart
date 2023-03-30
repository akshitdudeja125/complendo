import 'package:complaint_portal/models/user_model.dart';
import 'package:complaint_portal/common/providers/firebase_instance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepoProvider = Provider<UserRepository>((ref) => UserRepository());

class UserRepository {
  updateUser({
    required WidgetRef ref,
    required String uid,
    String? displayName,
    String? photoURL,
    String? rollNo,
    String? phoneNumber,
    String? hostel,
    String? roomNo,
    bool? isAdmin,
    // Function? onUpdateUserComplete,
  }) {
    final db = ref.read(firebaseFirestoreProvider).collection('users');
    db.doc(uid).update({
      if (displayName != null) 'displayName': displayName,
      if (photoURL != null) 'photoURL': photoURL,
      if (rollNo != null) 'rollNo': rollNo,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (hostel != null) 'hostel': hostel,
      if (roomNo != null) 'roomNo': roomNo,
      if (isAdmin != null) 'isAdmin': isAdmin,
    }).then((value) {
      // onUpdateUserComplete!();
    });
  }

  setUser({
    required WidgetRef ref,
    required String uid,
    required String displayName,
    required String email,
    String? photoURL,
    String? rollNo,
    String? phoneNumber,
    String? hostel,
    String? roomNo,
    bool? isAdmin,
  }) {
    final db = ref.watch(firebaseFirestoreProvider).collection('users');
    db.doc(uid).get().then((value) {
      if (!value.exists) {
        db
            .doc(uid)
            .set(UserModel(
              id: uid,
              name: displayName,
              email: email,
              photoURL: photoURL!,
              isAdmin: isAdmin ?? false,
              hostel: hostel!,
              phoneNumber: phoneNumber!,
              roomNo: roomNo!,
              rollNo: rollNo!,
            ).toMap())
            .then((value) {});
      } else {
        db.doc(uid).update({
          if (photoURL != null) 'photoURL': photoURL,
          if (rollNo != null) 'rollNo': rollNo,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
          if (hostel != null) 'hostel': hostel,
          if (roomNo != null) 'roomNo': roomNo,
          if (isAdmin != null) 'isAdmin': isAdmin,
        }).then((value) {});
      }
    });
  }
}
