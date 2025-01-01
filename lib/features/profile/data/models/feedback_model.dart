import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpnest/features/profile/domain/entities/feedback_entity.dart';

class FeedbackModel extends FeedbackEntity {
  FeedbackModel({
    required super.id,
    required super.rating,
    required super.module, // Profile
    required super.category, // Service Provider Feedback
    required super.title, // uid of the provider
    required super.description, // desc
    required super.creationTD,
    required super.createdBy,
    required super.deactivate,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] ?? '',
      rating: json['rating'] ?? 0,
      module: json['module'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      creationTD: json['creationTD'] ?? Timestamp.now(),
      createdBy: json['createdBy'] ?? '',
      deactivate: json['deactivate'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'module': module,
      'category': category,
      'title': title,
      'description': description,
      'creationTD': creationTD,
      'createdBy': createdBy,
      'deactivate': deactivate,
    };
  }

  @override
  String toString() {
    return 'FeedbackModel(id: $id, rating: $rating, module: $module, category: $category, title: $title, description: $description, creationTD: $creationTD, createdBy: $createdBy, deactivate: $deactivate)';
  }

  FeedbackModel copyWith({
    String? id,
    num? rating,
    String? module,
    String? category,
    String? title,
    String? description,
    Timestamp? creationTD,
    String? createdBy,
    bool? deactivate,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      module: module ?? this.module,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      creationTD: creationTD ?? this.creationTD,
      createdBy: createdBy ?? this.createdBy,
      deactivate: deactivate ?? this.deactivate,
    );
  }
}
