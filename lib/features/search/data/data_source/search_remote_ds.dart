import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/service/data/models/service_model.dart';
import 'package:helpnest/features/search/domain/repo/search_remote_repo.dart';

class SearchRemoteDs implements SearchRemoteRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<SearchParam> streamSearchResult({required String input}) async* {
    try {
      final serviceStream = _firestore
          .collection('services')
          .where('name', isGreaterThanOrEqualTo: input)
          .where('name', isLessThan: '$input\uf8ff')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ServiceModel.fromJson(doc.data()))
              .toList());

      final providerStream = _firestore
          .collection('service_providers')
          .where('name', isGreaterThanOrEqualTo: input)
          .where('name', isLessThan: '$input\uf8ff')
          .where('status', isEqualTo: "approved")
          .snapshots();

      await for (final providerSnapshot in providerStream) {
        final providerIds = providerSnapshot.docs
            .map((doc) => doc.data()['id'] as String? ?? "")
            .whereType<String>()
            .toList();

        final userStream = _firestore
            .collection('users')
            .where('id',
                whereIn: providerIds.isNotEmpty ? providerIds : ["dummy"])
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((doc) => UserModel.fromJson(doc.data()))
                .toList());

        await for (final services in serviceStream) {
          await for (final users in userStream) {
            yield SearchParam(providers: users, services: services);
          }
        }
      }
    } catch (e) {
      yield SearchParam(providers: [], services: []);
    }
  }

  @override
  Future<SearchParam> getSearchResult({required String input}) async {
    try {
      final servicesSnapshot = await _firestore
          .collection('services')
          .where('name', isGreaterThanOrEqualTo: input)
          .where('name', isLessThan: '$input\uf8ff')
          .get();

      final services = servicesSnapshot.docs
          .map((doc) => ServiceModel.fromJson(doc.data()))
          .toList();

      final providerSnapshot = await _firestore
          .collection('service_providers')
          .where('name', isGreaterThanOrEqualTo: input)
          .where('name', isLessThan: '$input\uf8ff')
          .where('status', isEqualTo: "approved")
          .get();

      final providerIds = providerSnapshot.docs
          .map((doc) => doc.data()['id'] as String?)
          .whereType<String>()
          .toList();

      final userSnapshot = await _firestore
          .collection('users')
          .where('id',
              whereIn: providerIds.isNotEmpty ? providerIds : ["dummy"])
          .get();

      final users = userSnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();

      return SearchParam(providers: users, services: services);
    } catch (e) {
      return SearchParam(providers: [], services: []);
    }
  }
}
