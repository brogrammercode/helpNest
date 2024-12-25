import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/auth/domain/repo/user_repo.dart';

class UserRemoteDs implements UserRepo {
  @override
  Stream<UserModel> getUserModelStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      } else {
        return UserModel.fromJson({});
      }
    });
  }
}
