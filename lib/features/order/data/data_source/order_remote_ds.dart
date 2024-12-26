import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:helpnest/features/order/data/models/order_model.dart';
import 'package:helpnest/features/order/domain/repo/order_repo.dart';

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
  Future<List<OrderModel>> getOrders() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("orders").get();

      // Convert QuerySnapshot into List<OrderModel>
      final List<OrderModel> orders = querySnapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return orders;
    } catch (e) {
      debugPrint("ORDER_REMOTE_DS_GET_ORDERS_ERROR: $e");
      return [];
    }
  }
}
