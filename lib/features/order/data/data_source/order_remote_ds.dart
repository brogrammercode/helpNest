import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/order/data/models/order_model.dart';
import 'package:helpnest/features/order/domain/repo/order_repo.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';
import 'package:helpnest/features/profile/data/models/service_provier_model.dart';

class OrderRemoteDs implements OrderRepo {
  @override
  Future<void> addOrder({required OrderModel order}) async {
    try {
      final String id = Timestamp.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(id)
          .set(order.copyWith(id: id).toJson());
    } catch (e) {
      debugPrint("ORDER_REMOTE_DS_ADD_ORDER_ERROR: $e");
    }
  }

  @override
Stream<List<GetOrderParam>> streamOrders() {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return Stream.value([]);

      return FirebaseFirestore.instance
          .collection("orders")
          .where("consumerID", isEqualTo: userId)
          .snapshots()
          .asyncMap((querySnapshot) async {
        if (querySnapshot.docs.isEmpty) return [];

        final providerIDs = querySnapshot.docs
            .map((doc) => doc["providerID"] as String)
            .toSet();

        if (providerIDs.isEmpty) return [];

        final providerSnapshots = await Future.wait([
          FirebaseFirestore.instance
              .collection("service_providers")
              .where(FieldPath.documentId, whereIn: providerIDs.toList())
              .get(),
          FirebaseFirestore.instance
              .collection("users")
              .where(FieldPath.documentId, whereIn: providerIDs.toList())
              .get(),
          FirebaseFirestore.instance
              .collection("feedbacks")
              .where("category", whereIn: providerIDs.toList())
              .where("title", isEqualTo: userId)
              .get(),
        ]);

        final providerDataMap = {
          for (var doc in providerSnapshots[0].docs)
            doc.id: ServiceProviderModel.fromJson(doc.data()),
        };
        final userDataMap = {
          for (var doc in providerSnapshots[1].docs)
            doc.id: UserModel.fromJson(doc.data()),
        };
        final feedbackMap = <String, List<FeedbackModel>>{};

        for (var doc in providerSnapshots[2].docs) {
          final feedback = FeedbackModel.fromJson(doc.data());
          final providerID = doc["category"];
          feedbackMap.putIfAbsent(providerID, () => []).add(feedback);
        }

        return querySnapshot.docs.map((doc) {
          final orderData = OrderModel.fromJson(doc.data());
          final providerID = orderData.providerID;

          return GetOrderParam(
            provider: providerDataMap[providerID] ??
                ServiceProviderModel.fromJson({}),
            user: userDataMap[providerID] ?? UserModel.fromJson({}),
            order: orderData,
            feedback: feedbackMap[providerID] ?? [],
          );
      }).toList();
      });
    } catch (e) {
      log("ORDER_REMOTE_DS_GET_ORDERS_ERROR: $e");
      return Stream.value([]);
    }
  }

}



