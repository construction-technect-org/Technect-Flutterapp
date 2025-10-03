class UpdatedRoleModel {
  final bool success;
  final UpdatedRole? data;
  final String message;

  UpdatedRoleModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UpdatedRoleModel.fromJson(Map<String, dynamic> json) {
    return UpdatedRoleModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? UpdatedRole.fromJson(json['data']) : null,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class  UpdatedRole {
  final int id;
  final int merchantProfileId;
  final String roleTitle;
  final String roleDescription;
  final String functionalities; // keep as raw string from API
  final bool isActive;
  final String createdAt;
  final String updatedAt;

   UpdatedRole({
    required this.id,
    required this.merchantProfileId,
    required this.roleTitle,
    required this.roleDescription,
    required this.functionalities,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdatedRole.fromJson(Map<String, dynamic> json) {
    return UpdatedRole(
      id: json['id'] ?? 0,
      merchantProfileId: json['merchant_profile_id'] ?? 0,
      roleTitle: json['role_title'] ?? '',
      roleDescription: json['role_description'] ?? '',
      functionalities: json['functionalities'] ?? '',
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Helper to convert the string to a list
  List<String> get functionalityList {
    // API sends string like {"view_products","edit_products"}
    return functionalities
        .replaceAll(RegExp(r'[\{\}]'), '') // remove { }
        .split(',')
        .map((e) => e.replaceAll('"', '').trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}
