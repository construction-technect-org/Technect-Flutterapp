// To parse this JSON data, do
//
//     final teamDetailsModel = teamDetailsModelFromJson(jsonString);

import 'dart:convert';

TeamDetailsModel teamDetailsModelFromJson(String str) => TeamDetailsModel.fromJson(json.decode(str));

String teamDetailsModelToJson(TeamDetailsModel data) => json.encode(data.toJson());

class TeamDetailsModel {
  final bool? success;
  final Data? data;

  TeamDetailsModel({
    this.success,
    this.data,
  });

  factory TeamDetailsModel.fromJson(Map<String, dynamic> json) => TeamDetailsModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  final int? id;
  final int? merchantProfileId;
  final int? teamRoleId;
  final String? profilePhotoUrl;
  final String? profilePhotoS3Key;
  final String? fullName;
  final String? emailId;
  final String? phoneNumber;
  final String? address;
  final String? state;
  final String? city;
  final String? pincode;
  final String? aadharCardNumber;
  final String? panCardNumber;
  final String? aadharCardPhotoUrl;
  final String? aadharCardPhotoS3Key;
  final String? panCardPhotoUrl;
  final String? panCardPhotoS3Key;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? roleTitle;
  final String? roleDescription;
  final String? functionalities;

  Data({
    this.id,
    this.merchantProfileId,
    this.teamRoleId,
    this.profilePhotoUrl,
    this.profilePhotoS3Key,
    this.fullName,
    this.emailId,
    this.phoneNumber,
    this.address,
    this.state,
    this.city,
    this.pincode,
    this.aadharCardNumber,
    this.panCardNumber,
    this.aadharCardPhotoUrl,
    this.aadharCardPhotoS3Key,
    this.panCardPhotoUrl,
    this.panCardPhotoS3Key,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.roleTitle,
    this.roleDescription,
    this.functionalities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    merchantProfileId: json["merchant_profile_id"],
    teamRoleId: json["team_role_id"],
    profilePhotoUrl: json["profile_photo_url"],
    profilePhotoS3Key: json["profile_photo_s3_key"],
    fullName: json["full_name"],
    emailId: json["email_id"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pincode: json["pincode"],
    aadharCardNumber: json["aadhar_card_number"],
    panCardNumber: json["pan_card_number"],
    aadharCardPhotoUrl: json["aadhar_card_photo_url"],
    aadharCardPhotoS3Key: json["aadhar_card_photo_s3_key"],
    panCardPhotoUrl: json["pan_card_photo_url"],
    panCardPhotoS3Key: json["pan_card_photo_s3_key"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    roleTitle: json["role_title"],
    roleDescription: json["role_description"],
    functionalities: json["functionalities"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_profile_id": merchantProfileId,
    "team_role_id": teamRoleId,
    "profile_photo_url": profilePhotoUrl,
    "profile_photo_s3_key": profilePhotoS3Key,
    "full_name": fullName,
    "email_id": emailId,
    "phone_number": phoneNumber,
    "address": address,
    "state": state,
    "city": city,
    "pincode": pincode,
    "aadhar_card_number": aadharCardNumber,
    "pan_card_number": panCardNumber,
    "aadhar_card_photo_url": aadharCardPhotoUrl,
    "aadhar_card_photo_s3_key": aadharCardPhotoS3Key,
    "pan_card_photo_url": panCardPhotoUrl,
    "pan_card_photo_s3_key": panCardPhotoS3Key,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "role_title": roleTitle,
    "role_description": roleDescription,
    "functionalities": functionalities,
  };
}
