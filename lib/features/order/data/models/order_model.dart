import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/order/domain/entities/order_entity.dart';
import 'package:helpnest/features/profile/data/models/feedback_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.consumerID,
    required super.providerID,
    required super.serviceID,
    required super.orderTD,
    required super.completionTD,
    required super.consumerLocation,
    required super.providerLocation,
    required super.feedback,
    required super.orderFee,
    required super.trackingPolylinePoints,
    required super.creationTD,
    required super.createdBy,
    required super.deactivate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      consumerID: json['consumerID'] ?? '',
      providerID: json['providerID'] ?? '',
      serviceID: json['serviceID'] ?? '',
      orderTD: json['orderTD'] ?? '',
      completionTD: json['completionTD'] ?? '',
      consumerLocation:
          UserLocationModel.fromJson(json['consumerLocation'] ?? {}),
      providerLocation:
          UserLocationModel.fromJson(json['providerLocation'] ?? {}),
      feedback: FeedbackModel.fromJson(json['feedback'] ?? {}),
      orderFee: json['orderFee'] ?? '',
      trackingPolylinePoints: json['trackingPolylinePoints'] ?? '',
      creationTD: json['creationTD'] ?? Timestamp.now(),
      createdBy: json['createdBy'] ?? '',
      deactivate: json['deactivate'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'consumerID': consumerID,
      'providerID': providerID,
      'serviceID': serviceID,
      'orderTD': orderTD,
      'completionTD': completionTD,
      'consumerLocation': consumerLocation.toJson(),
      'providerLocation': providerLocation.toJson(),
      'feedback': feedback.toJson(),
      'orderFee': orderFee,
      'trackingPolylinePoints': trackingPolylinePoints,
      'creationTD': creationTD,
      'createdBy': createdBy,
      'deactivate': deactivate,
    };
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, consumerID: $consumerID, providerID: $providerID, serviceID: $serviceID, orderTD: $orderTD, completionTD: $completionTD, consumerLocation: $consumerLocation, providerLocation: $providerLocation, feedback: $feedback, orderFee: $orderFee, trackingPolylinePoints: $trackingPolylinePoints, creationTD: $creationTD, createdBy: $createdBy, deactivate: $deactivate)';
  }

  OrderModel copyWith({
    String? id,
    String? consumerID,
    String? providerID,
    String? serviceID,
    String? orderTD,
    String? completionTD,
    UserLocationModel? consumerLocation,
    UserLocationModel? providerLocation,
    FeedbackModel? feedback,
    String? orderFee,
    String? trackingPolylinePoints,
    Timestamp? creationTD,
    String? createdBy,
    bool? deactivate,
  }) {
    return OrderModel(
      id: id ?? this.id,
      consumerID: consumerID ?? this.consumerID,
      providerID: providerID ?? this.providerID,
      serviceID: serviceID ?? this.serviceID,
      orderTD: orderTD ?? this.orderTD,
      completionTD: completionTD ?? this.completionTD,
      consumerLocation: consumerLocation ?? this.consumerLocation,
      providerLocation: providerLocation ?? this.providerLocation,
      feedback: feedback ?? this.feedback,
      orderFee: orderFee ?? this.orderFee,
      trackingPolylinePoints:
          trackingPolylinePoints ?? this.trackingPolylinePoints,
      creationTD: creationTD ?? this.creationTD,
      createdBy: createdBy ?? this.createdBy,
      deactivate: deactivate ?? this.deactivate,
    );
  }
}
