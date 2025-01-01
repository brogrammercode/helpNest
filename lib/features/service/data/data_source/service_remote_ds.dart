import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/order/data/models/order_model.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';
import 'package:helpnest/features/profile/data/models/service_provier_model.dart';
import 'package:helpnest/features/service/data/models/service_model.dart';
import 'package:helpnest/features/service/domain/repo/service_repo.dart';

class ServiceRemoteDs implements ServiceRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addOrder({required OrderModel order}) async {
    try {
      await firestore.collection('orders').doc(order.id).set(order.toJson());
    } catch (e) {
      throw Exception('Error adding order: $e');
    }
  }


  @override
  Future<List<FindServiceProviderParams>> findServiceProvider(
      {required String serviceID}) async {
    try {
      QuerySnapshot serviceProvidersSnapshot = await firestore
          .collection('service_providers')
          .where('serviceID', isEqualTo: serviceID)
          .get();

      List<ServiceProviderModel> serviceProviders = serviceProvidersSnapshot
          .docs
          .map((doc) =>
              ServiceProviderModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      List<UserModel> users = await _getUsersForProviders(serviceProviders);
      List<FeedbackModel> feedbacks =
          await _getFeedbacksForProviders(serviceProviders);

      return [
        FindServiceProviderParams(
          serviceProviders: serviceProviders,
          users: users,
          feedbacks: feedbacks,
        ),
      ];
    } catch (e) {
      throw Exception('Error finding service providers params: $e');
    }
  }

  Future<List<UserModel>> _getUsersForProviders(
      List<ServiceProviderModel> providers) async {
    List<UserModel> users = [];
    for (var provider in providers) {
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(provider.id).get();
      users
          .add(UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>));
    }
    return users;
  }

  Future<List<FeedbackModel>> _getFeedbacksForProviders(
      List<ServiceProviderModel> providers) async {
    List<FeedbackModel> feedbacks = [];
    for (var provider in providers) {
      QuerySnapshot feedbackSnapshot = await firestore
          .collection('feedbacks')
          .where('title', isEqualTo: provider.id)
          .get();
      feedbacks.addAll(feedbackSnapshot.docs
          .map((doc) =>
              FeedbackModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    }
    return feedbacks;
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      QuerySnapshot serviceSnapshot =
          await firestore.collection('services').get();

      return serviceSnapshot.docs
          .map((doc) =>
              ServiceModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching services: $e');
    }
  }
}
