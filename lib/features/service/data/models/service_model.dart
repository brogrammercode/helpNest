import 'package:helpnest/features/service/domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.id,
    required super.name,
    required super.logo,
    required super.description,
    required super.creationTD,
    required super.createdBy,
    required super.deactivate,
    required super.avgCharge,
    required super.avgTime,
    required super.slides,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      creationTD: json['creationTD'] ?? '',
      createdBy: json['createdBy'] ?? '',
      deactivate: json['deactivate'] ?? false,
      avgCharge: json['avgCharge'] ?? '',
      avgTime: json['avgTime'] ?? '',
      slides: json['slides'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'description': description,
      'creationTD': creationTD,
      'createdBy': createdBy,
      'deactivate': deactivate,
      'avgCharge': avgCharge,
      'avgTime': avgTime,
      'slides': slides,
    };
  }

  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, logo: $logo, description: $description, creationTD: $creationTD, createdBy: $createdBy, deactivate: $deactivate, avgCharge: $avgCharge, avgTime: $avgTime, slides: $slides)';
  }

  ServiceModel copyWith({
    String? id,
    String? name,
    String? logo,
    String? description,
    String? creationTD,
    String? createdBy,
    bool? deactivate,
    String? avgCharge,
    String? avgTime,
    List? slides,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      description: description ?? this.description,
      creationTD: creationTD ?? this.creationTD,
      createdBy: createdBy ?? this.createdBy,
      deactivate: deactivate ?? this.deactivate,
      avgCharge: avgCharge ?? this.avgCharge,
      avgTime: avgTime ?? this.avgTime,
      slides: slides ?? this.slides,
    );
  }
}
