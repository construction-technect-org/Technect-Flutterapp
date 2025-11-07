
import 'package:construction_technect/app/modules/MarketPlace/Partner/Home/home/models/ProfileModel.dart';

class AddKycModel {
  bool success;
  String message;
  AddKyc data;

  AddKycModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddKycModel.fromJson(Map<String, dynamic> json) {
    return AddKycModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AddKyc.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AddKyc {
  int id;
  int userId;
  String aadhaarNumber;
  String panNumber;
  int profileCompletionPercentage;
  bool isProfileComplete;
  bool kycVerified;
  String trustScore;
  String marketplaceTier;
  DateTime memberSince;
  DateTime createdAt;
  DateTime updatedAt;
  VerificationStatus verificationStatus;
  String? aadhaarFront;
  String? aadhaarBack;
  String? panFront;
  String? panBack;

  AddKyc({
    required this.id,
    required this.userId,
    required this.aadhaarNumber,
    required this.panNumber,
    required this.profileCompletionPercentage,
    required this.isProfileComplete,
    required this.kycVerified,
    required this.trustScore,
    required this.marketplaceTier,
    required this.memberSince,
    required this.createdAt,
    required this.updatedAt,
    required this.verificationStatus,
    this.aadhaarFront,
    this.aadhaarBack,
    this.panFront,
    this.panBack,
  });

  factory AddKyc.fromJson(Map<String, dynamic> json) {
    return AddKyc(
      id: json['id'],
      userId: json['user_id'],
      aadhaarNumber: json['aadhaar_number'] ?? '',
      panNumber: json['pan_number'] ?? '',
      profileCompletionPercentage: json['profile_completion_percentage'] ?? 0,
      isProfileComplete: json['is_profile_complete'] ?? false,
      kycVerified: json['kyc_verified'] ?? false,
      trustScore: json['trust_score'] ?? '',
      marketplaceTier: json['marketplace_tier'] ?? '',
      memberSince: DateTime.parse(json['member_since']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      verificationStatus: VerificationStatus.fromJson(json['verification_status']),
      aadhaarFront: json['aadhaar_front'],
      aadhaarBack: json['aadhaar_back'],
      panFront: json['pan_front'],
      panBack: json['pan_back'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'aadhaar_number': aadhaarNumber,
      'pan_number': panNumber,
      'profile_completion_percentage': profileCompletionPercentage,
      'is_profile_complete': isProfileComplete,
      'kyc_verified': kycVerified,
      'trust_score': trustScore,
      'marketplace_tier': marketplaceTier,
      'member_since': memberSince.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'verification_status': verificationStatus.toJson(),
      'aadhaar_front': aadhaarFront,
      'aadhaar_back': aadhaarBack,
      'pan_front': panFront,
      'pan_back': panBack,
    };
  }
}
