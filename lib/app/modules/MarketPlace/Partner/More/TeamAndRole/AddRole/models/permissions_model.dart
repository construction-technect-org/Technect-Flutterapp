class PermissionsModel {
  bool? success;
  List<UserPermissions>? permissions;

  PermissionsModel({this.success, this.permissions});

  PermissionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['permissions'] != null) {
      permissions = <UserPermissions>[];
      json['permissions'].forEach((v) {
        permissions?.add(UserPermissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (this.permissions != null) {
      data['permissions'] = this.permissions?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPermissions {
  String? id;
  String? code;
  String? name;
  String? description;
  String? category;
  String? permissionFor;
  String? createdAt;
  String? updatedAt;

  UserPermissions({
    this.id,
    this.code,
    this.name,
    this.description,
    this.category,
    this.permissionFor,
    this.createdAt,
    this.updatedAt,
  });

  UserPermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    permissionFor = json['permissionFor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['permissionFor'] = this.permissionFor;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
