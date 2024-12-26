import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';

class OrderEntity {
  final String id;
  final String consumerID;
  final String providerID;
  final String serviceID;
  final String orderTD;
  final String completionTD;
  final UserLocationModel location;
  final FeedbackModel feedback;
  final String orderFee;
  final String trackingPolylinePoints;
  final Timestamp creationTD;
  final String createdBy;
  final bool deactivate;

  OrderEntity(
      {required this.id,
      required this.consumerID,
      required this.providerID,
      required this.serviceID,
      required this.orderTD,
      required this.completionTD,
      required this.location,
      required this.feedback,
      required this.orderFee,
      required this.trackingPolylinePoints,
      required this.creationTD,
      required this.createdBy,
      required this.deactivate});
}
