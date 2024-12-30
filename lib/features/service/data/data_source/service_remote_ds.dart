import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpnest/features/service/data/models/service_model.dart';
import 'package:helpnest/features/service/domain/repo/service_repo.dart';

class ServiceRemoteDs implements ServiceRepo {
  @override
  Future<void> addService({required ServiceModel service}) async {
    try {
      final String id = Timestamp.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance
          .collection("services")
          .doc(id)
          .set(service.copyWith(id: id).toJson());
    } catch (e) {
      debugPrint("SERVICE_REMOTE_DS_ADD_SERVICE_ERROR: $e");
    }
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("services").get();

      return querySnapshot.docs.map((doc) {
        return ServiceModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint("SERVICE_REMOTE_DS_GET_SERVICES_ERROR: $e");
      return [];
    }
  }

  @override
  Future<void> deleteService({required List<ServiceModel> service}) async {
    try {
      for (var s in service) {
        await FirebaseFirestore.instance
            .collection("services")
            .doc(s.id)
            .delete();
        debugPrint("Deleted service with ID: ${s.id}");
      }
    } catch (e) {
      debugPrint("SERVICE_REMOTE_DS_DELETE_SERVICE_ERROR: $e");
    }
  }

  @override
  Future<void> updateService({required ServiceModel service}) async {
    try {
      await FirebaseFirestore.instance
          .collection("services")
          .doc(service.id)
          .update(service.toJson());
      debugPrint("Updated service with ID: ${service.id}");
    } catch (e) {
      debugPrint("SERVICE_REMOTE_DS_UPDATE_SERVICE_ERROR: $e");
    }
  }
}
