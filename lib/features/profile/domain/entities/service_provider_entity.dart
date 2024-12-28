import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderEntity {
  final String id;
  final String aadharCardImageURL;
  final String status;
  final String approvedTD;
  final String approvedBy;
  final List services;
  final String experienceDocImageURL;
  final Timestamp creationTD;
  final String createdBy;
  final bool deactivate;

  ServiceProviderEntity(
      {required this.id,
      required this.aadharCardImageURL,
      required this.status,
      required this.approvedTD,
      required this.approvedBy,
      required this.services,
      required this.experienceDocImageURL,
      required this.creationTD,
      required this.createdBy,
      required this.deactivate});
}
