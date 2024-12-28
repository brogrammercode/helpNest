import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpnest/features/profile/data/models/service_provier_model.dart';
import 'package:helpnest/features/profile/domain/repo/profile_repo.dart';

class ProfileRemoteDs implements ServiceProviderRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addServiceProviders(
      {required ServiceProviderModel provider}) async {
    try {
      // Generate a unique ID for the service provider
      final String id = Timestamp.now().millisecondsSinceEpoch.toString();

      // Add the service provider to Firestore
      await _firestore
          .collection("service_providers")
          .doc(id)
          .set(provider.copyWith(id: id).toJson());

      debugPrint('Service provider added successfully: ${provider.name}');
    } catch (e) {
      debugPrint('ORDER_REMOTE_DS_ADD_SERVICE_PROVIDER_ERROR: $e');
      rethrow; // Rethrow for higher-level error handling
    }
  }

  @override
  Future<List<ServiceProviderModel>> getServiceProviders() async {
    try {
      // Fetch all documents from the 'service_providers' collection
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("service_providers").get();

      // Map Firestore documents to a list of ServiceProviderModel
      final List<ServiceProviderModel> providers = snapshot.docs
          .map((doc) => ServiceProviderModel.fromJson(doc.data()))
          .toList();

      debugPrint('Fetched ${providers.length} service providers.');
      return providers;
    } catch (e) {
      debugPrint('ORDER_REMOTE_DS_GET_SERVICE_PROVIDERS_ERROR: $e');
      rethrow; // Rethrow for higher-level error handling
    }
  }
}
