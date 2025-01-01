import 'dart:async';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/order/data/models/order_model.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';
import 'package:helpnest/features/profile/data/models/service_provier_model.dart';
import 'package:helpnest/features/service/data/models/service_model.dart';

abstract class ServiceRepo {
  Future<List<ServiceModel>> getServices();
  Future<List<FindServiceProviderParams>> findServiceProvider(
      {required String serviceID});
  Future<void> addOrder({required OrderModel order});
}

class FindServiceProviderParams {
  final List<ServiceProviderModel> serviceProviders;
  final List<UserModel> users;
  final List<FeedbackModel> feedbacks;

  FindServiceProviderParams(
      {required this.serviceProviders,
      required this.users,
      required this.feedbacks});
}
