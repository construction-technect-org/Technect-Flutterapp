class AddRoleModel {
  final bool? success;
  final String? message;
  final CustomRole? customRole;

  AddRoleModel({
    this.success,
    this.message,
    this.customRole,
  });

  factory AddRoleModel.fromJson(Map<String, dynamic> json) {
    return AddRoleModel(
      success: json['success'],
      message: json['message'],
      customRole: json['customRole'] != null
          ? CustomRole.fromJson(json['customRole'])
          : null,
    );
  }
}

class CustomRole {
  final String? id;
  final String? profileId;
  final String? profileType;
  final String? roleName;
  final String? description;
  final String? createdBy;
  final List<String>? permissions;
  final String? createdAt;
  final String? updatedAt;

  CustomRole({
    this.id,
    this.profileId,
    this.profileType,
    this.roleName,
    this.description,
    this.createdBy,
    this.permissions,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomRole.fromJson(Map<String, dynamic> json) {
    return CustomRole(
      id: json['id'],
      profileId: json['profileId'],
      profileType: json['profileType'],
      roleName: json['roleName'],
      description: json['description'],
      createdBy: json['createdBy'],
      permissions: json['permissions'] != null
          ? List<String>.from(json['permissions'])
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}