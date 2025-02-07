import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/home/domain/repo/home_remote_repo.dart';

class HomeRemoteDs implements HomeRemoteRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserLocationModel?> getLocationFromDatabase() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    final doc = await _firestore.collection('users').doc(userId).get();
    final data = doc.data();
    if (data == null || !data.containsKey('location')) return null;

    return UserLocationModel.fromJson(data['location']);
  }

  @override
  Future<void> updateLocationToDatabase(
      {required UserLocationModel location}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).set(
      {"location": location.toJson()},
      SetOptions(merge: true),
    );
  }
}
