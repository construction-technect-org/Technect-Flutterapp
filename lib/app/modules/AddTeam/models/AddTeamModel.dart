// lib/app/modules/team_member/models/create_team_member_response.dart

import 'dart:convert';

class AddTeamModel {
  final bool success;
  final String message;
  final AddTeam data;

  const AddTeamModel({
    required this.success,
    required this.message,
    required this.data,
  });

  AddTeamModel copyWith({
    bool? success,
    String? message,
    AddTeam? data,
  }) {
    return AddTeamModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory AddTeamModel.fromMap(Map<String, dynamic> map) {
    return AddTeamModel(
      success: map['success'] as bool? ?? false,
      message: map['message'] as String? ?? '',
      data: AddTeam.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory AddTeamModel.fromJson(String source) =>
      AddTeamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddTeamModel &&
        other.success == success &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}

class AddTeam {
  final int id;
  final int merchantProfileId;
  final int teamRoleId;
  final String? profilePhotoUrl;
  final String? profilePhotoS3Key;
  final String fullName;
  final String emailId;
  final String phoneNumber;
  final String address;
  final String state;
  final String city;
  final String pincode;
  final String aadharCardNumber;
  final String panCardNumber;
  final String? aadharCardPhotoUrl;
  final String? aadharCardPhotoS3Key;
  final String? panCardPhotoUrl;
  final String? panCardPhotoS3Key;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AddTeam({
    required this.id,
    required this.merchantProfileId,
    required this.teamRoleId,
    required this.profilePhotoUrl,
    required this.profilePhotoS3Key,
    required this.fullName,
    required this.emailId,
    required this.phoneNumber,
    required this.address,
    required this.state,
    required this.city,
    required this.pincode,
    required this.aadharCardNumber,
    required this.panCardNumber,
    required this.aadharCardPhotoUrl,
    required this.aadharCardPhotoS3Key,
    required this.panCardPhotoUrl,
    required this.panCardPhotoS3Key,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  AddTeam copyWith({
    int? id,
    int? merchantProfileId,
    int? teamRoleId,
    String? profilePhotoUrl,
    String? profilePhotoS3Key,
    String? fullName,
    String? emailId,
    String? phoneNumber,
    String? address,
    String? state,
    String? city,
    String? pincode,
    String? aadharCardNumber,
    String? panCardNumber,
    String? aadharCardPhotoUrl,
    String? aadharCardPhotoS3Key,
    String? panCardPhotoUrl,
    String? panCardPhotoS3Key,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AddTeam(
      id: id ?? this.id,
      merchantProfileId: merchantProfileId ?? this.merchantProfileId,
      teamRoleId: teamRoleId ?? this.teamRoleId,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      profilePhotoS3Key: profilePhotoS3Key ?? this.profilePhotoS3Key,
      fullName: fullName ?? this.fullName,
      emailId: emailId ?? this.emailId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      state: state ?? this.state,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      aadharCardNumber: aadharCardNumber ?? this.aadharCardNumber,
      panCardNumber: panCardNumber ?? this.panCardNumber,
      aadharCardPhotoUrl: aadharCardPhotoUrl ?? this.aadharCardPhotoUrl,
      aadharCardPhotoS3Key: aadharCardPhotoS3Key ?? this.aadharCardPhotoS3Key,
      panCardPhotoUrl: panCardPhotoUrl ?? this.panCardPhotoUrl,
      panCardPhotoS3Key: panCardPhotoS3Key ?? this.panCardPhotoS3Key,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory AddTeam.fromMap(Map<String, dynamic> map) {
    return AddTeam(
      id: (map['id'] as num).toInt(),
      merchantProfileId: (map['merchant_profile_id'] as num).toInt(),
      teamRoleId: (map['team_role_id'] as num).toInt(),
      profilePhotoUrl: map['profile_photo_url'] as String?,
      profilePhotoS3Key: map['profile_photo_s3_key'] as String?,
      fullName: map['full_name'] as String? ?? '',
      emailId: map['email_id'] as String? ?? '',
      phoneNumber: map['phone_number'] as String? ?? '',
      address: map['address'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      pincode: map['pincode'] as String? ?? '',
      aadharCardNumber: map['aadhar_card_number'] as String? ?? '',
      panCardNumber: map['pan_card_number'] as String? ?? '',
      aadharCardPhotoUrl: map['aadhar_card_photo_url'] as String?,
      aadharCardPhotoS3Key: map['aadhar_card_photo_s3_key'] as String?,
      panCardPhotoUrl: map['pan_card_photo_url'] as String?,
      panCardPhotoS3Key: map['pan_card_photo_s3_key'] as String?,
      isActive: map['is_active'] as bool? ?? false,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'merchant_profile_id': merchantProfileId,
      'team_role_id': teamRoleId,
      'profile_photo_url': profilePhotoUrl,
      'profile_photo_s3_key': profilePhotoS3Key,
      'full_name': fullName,
      'email_id': emailId,
      'phone_number': phoneNumber,
      'address': address,
      'state': state,
      'city': city,
      'pincode': pincode,
      'aadhar_card_number': aadharCardNumber,
      'pan_card_number': panCardNumber,
      'aadhar_card_photo_url': aadharCardPhotoUrl,
      'aadhar_card_photo_s3_key': aadharCardPhotoS3Key,
      'pan_card_photo_url': panCardPhotoUrl,
      'pan_card_photo_s3_key': panCardPhotoS3Key,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory AddTeam.fromJson(String source) =>
      AddTeam.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddTeam &&
        other.id == id &&
        other.merchantProfileId == merchantProfileId &&
        other.teamRoleId == teamRoleId &&
        other.profilePhotoUrl == profilePhotoUrl &&
        other.profilePhotoS3Key == profilePhotoS3Key &&
        other.fullName == fullName &&
        other.emailId == emailId &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.state == state &&
        other.city == city &&
        other.pincode == pincode &&
        other.aadharCardNumber == aadharCardNumber &&
        other.panCardNumber == panCardNumber &&
        other.aadharCardPhotoUrl == aadharCardPhotoUrl &&
        other.aadharCardPhotoS3Key == aadharCardPhotoS3Key &&
        other.panCardPhotoUrl == panCardPhotoUrl &&
        other.panCardPhotoS3Key == panCardPhotoS3Key &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        merchantProfileId.hashCode ^
        teamRoleId.hashCode ^
        (profilePhotoUrl?.hashCode ?? 0) ^
        (profilePhotoS3Key?.hashCode ?? 0) ^
        fullName.hashCode ^
        emailId.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode ^
        state.hashCode ^
        city.hashCode ^
        pincode.hashCode ^
        aadharCardNumber.hashCode ^
        panCardNumber.hashCode ^
        (aadharCardPhotoUrl?.hashCode ?? 0) ^
        (aadharCardPhotoS3Key?.hashCode ?? 0) ^
        (panCardPhotoUrl?.hashCode ?? 0) ^
        (panCardPhotoS3Key?.hashCode ?? 0) ^
        isActive.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
