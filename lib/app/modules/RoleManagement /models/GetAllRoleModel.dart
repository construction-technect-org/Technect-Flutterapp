class GetAllRoleModel {
  final bool success;
  final List<GetAllRole> data;
  final String message;

  GetAllRoleModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetAllRoleModel.fromJson(Map<String, dynamic> json) {
    return GetAllRoleModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => GetAllRole.fromJson(item))
              .toList() ??
          [],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "data": data.map((e) => e.toJson()).toList(),
      "message": message,
    };
  }
}

class GetAllRole {
  final int id;
  final int merchantProfileId;
  final String roleTitle;
  final String roleDescription;
  final String functionalities;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  GetAllRole({
    required this.id,
    required this.merchantProfileId,
    required this.roleTitle,
    required this.roleDescription,
    required this.functionalities,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetAllRole.fromJson(Map<String, dynamic> json) {
    return GetAllRole(
      id: json['id'] ?? 0,
      merchantProfileId: json['merchant_profile_id'] ?? 0,
      roleTitle: json['role_title']?.trim() ?? '',
      roleDescription: json['role_description'] ?? '',
      functionalities: json['functionalities']?.toString() ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "merchant_profile_id": merchantProfileId,
      "role_title": roleTitle,
      "role_description": roleDescription,
      "functionalities": functionalities,
      "is_active": isActive,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
