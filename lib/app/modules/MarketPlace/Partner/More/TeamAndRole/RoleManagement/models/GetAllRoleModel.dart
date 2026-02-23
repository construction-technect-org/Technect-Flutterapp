class GetAllRoleModel {
  final bool? success;
  final List<GetAllRole>? customRoles;

  GetAllRoleModel({
    this.success,
    this.customRoles,
  });

  factory GetAllRoleModel.fromJson(Map<String, dynamic> json) {
    return GetAllRoleModel(
      success: json['success'],
      customRoles: json['customRoles'] != null
          ? List<GetAllRole>.from(
        json['customRoles'].map((x) => GetAllRole.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'customRoles': customRoles?.map((x) => x.toJson()).toList(),
    };
  }
}

class GetAllRole {
  final String? id;
  final String? profileId;
  final String? profileType;
  final String? roleName;
  final String? description;
  final String? createdBy;
  final List<String>? permissions;
  final String? createdAt;
  final String? updatedAt;

  GetAllRole({
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

  factory GetAllRole.fromJson(Map<String, dynamic> json) {
    return GetAllRole(
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

  // ✅ toJson added
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'profileType': profileType,
      'roleName': roleName,
      'description': description,
      'createdBy': createdBy,
      'permissions': permissions,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}