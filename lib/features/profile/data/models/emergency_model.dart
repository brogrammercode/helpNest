import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpnest/features/auth/data/models/user_model.dart';
import 'package:helpnest/features/profile/domain/entities/emergency_entity.dart';

class EmergencyModel extends EmergencyEntity {
  EmergencyModel({
    required super.id,
    required super.emergencyTD,
    required super.location,
    required super.reportedBy,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emergencyTD': emergencyTD,
      'location': location.toJson(),
      'reportedBy': reportedBy,
    };
  }

  @override
  String toString() {
    return 'EmergencyModel(id: $id, emergencyTD: $emergencyTD, location: $location, reportedBy: $reportedBy)';
  }

  EmergencyModel copyWith({
    String? id,
    Timestamp? emergencyTD,
    UserLocationModel? location,
    String? reportedBy,
  }) {
    return EmergencyModel(
      id: id ?? this.id,
      emergencyTD: emergencyTD ?? this.emergencyTD,
      location: location ?? this.location,
      reportedBy: reportedBy ?? this.reportedBy,
    );
  }
}
