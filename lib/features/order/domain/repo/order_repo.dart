import 'package:helpnest/features/order/data/models/order_model.dart';

abstract class OrderRepo {
  Future<List<OrderModel>> getOrders();
  Future<void> addOrder({required OrderModel order});
}
