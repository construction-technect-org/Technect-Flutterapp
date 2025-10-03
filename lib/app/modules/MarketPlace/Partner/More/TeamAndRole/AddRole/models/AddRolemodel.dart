class AddRolemodel {
  final bool success;
  final AddRole? data;
  final String message;

  AddRolemodel({required this.success, required this.data, required this.message});

  factory AddRolemodel.fromJson(Map<String, dynamic> json) {
    return AddRolemodel(
      success: json['success'] ?? false,
      data: json['data'] != null ? AddRole.fromJson(json['data']) : null,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data?.toJson(), 'message': message};
  }
}

class AddRole {
  final int id;
  final int merchantProfileId;
  final String roleTitle;
  final String roleDescription;
  final String functionalities;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddRole({
    required this.id,
    required this.merchantProfileId,
    required this.roleTitle,
    required this.roleDescription,
    required this.functionalities,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddRole.fromJson(Map<String, dynamic> json) {
    return AddRole(
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
      'id': id,
      'merchant_profile_id': merchantProfileId,
      'role_title': roleTitle,
      'role_description': roleDescription,
      'functionalities': functionalities,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
