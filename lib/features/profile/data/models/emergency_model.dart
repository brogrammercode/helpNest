import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/profile/domain/entities/emergency_entity.dart';

class EmergencyModel extends EmergencyEntity {
  EmergencyModel({
    required super.id,
    required super.emergencyTD,
    required super.location,
    required super.reportedBy,
    required super.adminResponse,
    required super.resolved,
  });

  factory EmergencyModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON cannot be null');
    }
    return EmergencyModel(
      id: json['id'] ?? '',
      emergencyTD: json['emergencyTD'] ?? Timestamp.now(),
      location: UserLocationModel.fromJson(json['location'] ?? {}),
      reportedBy: json['reportedBy'] ?? '',
      adminResponse: json['adminResponse'] ?? '',
      resolved: json['resolved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emergencyTD': emergencyTD,
      'location': location.toJson(),
      'reportedBy': reportedBy,
      'adminResponse': adminResponse,
      'resolved': resolved,
    };
  }

  @override
  String toString() {
    return 'EmergencyModel(id: $id, emergencyTD: $emergencyTD, location: $location, reportedBy: $reportedBy, adminResponse: $adminResponse, resolved: $resolved)';
  }

  EmergencyModel copyWith({
    String? id,
    Timestamp? emergencyTD,
    UserLocationModel? location,
    String? reportedBy,
    String? adminResponse,
    bool? resolved,
  }) {
    return EmergencyModel(
      id: id ?? this.id,
      emergencyTD: emergencyTD ?? this.emergencyTD,
      location: location ?? this.location,
      reportedBy: reportedBy ?? this.reportedBy,
      adminResponse: adminResponse ?? this.adminResponse,
      resolved: resolved ?? this.resolved,
    );
  }
}
