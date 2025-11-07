class SupportTicketPrioritiesModel {
  final bool success;
  final List<SupportPriority> data;
  final String message;

  SupportTicketPrioritiesModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SupportTicketPrioritiesModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketPrioritiesModel(
      success: json['success'] ?? false,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => SupportPriority.fromJson(e))
              .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class SupportPriority {
  final int id;
  final String name;
  final String description;
  final String colorCode;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  SupportPriority({
    required this.id,
    required this.name,
    required this.description,
    required this.colorCode,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportPriority.fromJson(Map<String, dynamic> json) {
    return SupportPriority(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      colorCode: json['color_code'] ?? '',
      isActive: json['is_active'] ?? false,
      sortOrder: json['sort_order'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color_code': colorCode,
      'is_active': isActive,
      'sort_order': sortOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
