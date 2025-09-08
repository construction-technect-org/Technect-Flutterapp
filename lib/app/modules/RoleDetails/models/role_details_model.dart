// To parse this JSON data, do
//
//     final roleDetailsModel = roleDetailsModelFromJson(jsonString);

import 'dart:convert';

RoleDetailsModel roleDetailsModelFromJson(String str) => RoleDetailsModel.fromJson(json.decode(str));

String roleDetailsModelToJson(RoleDetailsModel data) => json.encode(data.toJson());

class RoleDetailsModel {
  final bool? success;
  final Data? data;
  final String? message;

  RoleDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory RoleDetailsModel.fromJson(Map<String, dynamic> json) => RoleDetailsModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final int? id;
  final int? merchantProfileId;
  final String? roleTitle;
  final String? roleDescription;
  final dynamic? functionalities;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.merchantProfileId,
    this.roleTitle,
    this.roleDescription,
    this.functionalities,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    merchantProfileId: json["merchant_profile_id"],
    roleTitle: json["role_title"],
    roleDescription: json["role_description"],
    functionalities: json["functionalities"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_profile_id": merchantProfileId,
    "role_title": roleTitle,
    "role_description": roleDescription,
    "functionalities": functionalities,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
