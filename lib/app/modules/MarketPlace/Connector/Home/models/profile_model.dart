class ProfileModelM {
  final bool? success;
  final String? message;
  final User? user;
  final MerchantProfile? merchantProfile;
  final ConnectorProfile? connectorProfile;

  ProfileModelM({
    this.success,
    this.message,
    this.user,
    this.merchantProfile,
    this.connectorProfile,
  });

  factory ProfileModelM.fromJson(Map<String, dynamic> json) {
    // ✅ Debug — kaunsa field complex hai
    json.forEach((key, value) {
      if (value is Map || value is List) {
        print('⚠️ Complex field: $key = $value');
      }
    });

    return ProfileModelM(
      success: json['success'],
      message: _parseString(json['message']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      merchantProfile: json['merchantProfile'] != null
          ? MerchantProfile.fromJson(json['merchantProfile'])
          : null,
      connectorProfile: json['connectorProfile'] != null
          ? ConnectorProfile.fromJson(json['connectorProfile'])
          : null,
    );
  }

  // ✅ Global helper — String, Map, List sab handle karega
  static String? _parseString(dynamic raw) {
    if (raw == null) return null;
    if (raw is String) return raw;
    if (raw is Map) return raw.values.join(', ');
    if (raw is List) return raw.join(', ');
    return raw.toString();
  }
}

// ─────────────────────────────────────────────
class User {
  final String? id;
  final String? countryCode;
  final String? phone;
  final String? email;
  final String? passwordHash;
  final String? provider;
  final String? providerId;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? referralCode;
  final String? myReferralCode;
  final bool? phoneVerified;
  final bool? emailVerified;
  final String? lastActiveProfileId;
  final String? lastActiveProfileType;
  final String? status;
  final String? signupStatus;
  final int? sessionVersion;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  User({
    this.id,
    this.countryCode,
    this.phone,
    this.email,
    this.passwordHash,
    this.provider,
    this.providerId,
    this.firstName,
    this.lastName,
    this.address,
    this.referralCode,
    this.myReferralCode,
    this.phoneVerified,
    this.emailVerified,
    this.lastActiveProfileId,
    this.lastActiveProfileType,
    this.status,
    this.signupStatus,
    this.sessionVersion,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: ProfileModelM._parseString(json['id']),
      countryCode: ProfileModelM._parseString(json['countryCode']),
      phone: ProfileModelM._parseString(json['phone']),
      email: ProfileModelM._parseString(json['email']),
      passwordHash: ProfileModelM._parseString(json['passwordHash']),
      provider: ProfileModelM._parseString(json['provider']),
      providerId: ProfileModelM._parseString(json['providerId']),
      firstName: ProfileModelM._parseString(json['firstName']),
      lastName: ProfileModelM._parseString(json['lastName']),
      address: ProfileModelM._parseString(json['address']), // ✅ Map safe
      referralCode: ProfileModelM._parseString(json['referralCode']),
      myReferralCode: ProfileModelM._parseString(json['myReferralCode']),
      phoneVerified: json['phoneVerified'],
      emailVerified: json['emailVerified'],
      lastActiveProfileId: ProfileModelM._parseString(json['lastActiveProfileId']),
      lastActiveProfileType: ProfileModelM._parseString(json['lastActiveProfileType']),
      status: ProfileModelM._parseString(json['status']),
      signupStatus: ProfileModelM._parseString(json['signupStatus']),
      sessionVersion: json['sessionVersion'],
      createdAt: ProfileModelM._parseString(json['createdAt']),
      updatedAt: ProfileModelM._parseString(json['updatedAt']),
      deletedAt: ProfileModelM._parseString(json['deletedAt']),
    );
  }
}

// ─────────────────────────────────────────────
class MerchantProfile {
  final String? id;
  final String? ownerUserId;
  final String? verificationId;
  final String? verificationType;
  final String? gstinHash;
  final dynamic verificationDetails;
  final String? verifiedAt;
  final String? businessName;
  final String? businessType;
  final String? businessWebsite;
  final String? businessEmail;
  final String? businessPhone;
  final String? alternateBusinessPhone;
  final String? yearOfEstablish;
  final String? logo;
  final String? businessAddress;
  final dynamic businessHours;
  final dynamic certifications;
  final dynamic pocDetails;
  final String? profileStatus;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  MerchantProfile({
    this.id,
    this.ownerUserId,
    this.verificationId,
    this.verificationType,
    this.gstinHash,
    this.verificationDetails,
    this.verifiedAt,
    this.businessName,
    this.businessType,
    this.businessWebsite,
    this.businessEmail,
    this.businessPhone,
    this.alternateBusinessPhone,
    this.yearOfEstablish,
    this.logo,
    this.businessAddress,
    this.businessHours,
    this.certifications,
    this.pocDetails,
    this.profileStatus,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      id: ProfileModelM._parseString(json['id']),
      ownerUserId: ProfileModelM._parseString(json['ownerUserId']),
      verificationId: ProfileModelM._parseString(json['verificationId']),
      verificationType: ProfileModelM._parseString(json['verificationType']),
      gstinHash: ProfileModelM._parseString(json['gstinHash']),
      verificationDetails: json['verificationDetails'],
      verifiedAt: ProfileModelM._parseString(json['verifiedAt']),
      businessName: ProfileModelM._parseString(json['businessName']),
      businessType: ProfileModelM._parseString(json['businessType']),
      businessWebsite: ProfileModelM._parseString(json['businessWebsite']),
      businessEmail: ProfileModelM._parseString(json['businessEmail']),
      businessPhone: ProfileModelM._parseString(json['businessPhone']),
      alternateBusinessPhone: ProfileModelM._parseString(json['alternateBusinessPhone']),
      yearOfEstablish: ProfileModelM._parseString(json['yearOfEstablish']),
      logo: ProfileModelM._parseString(json['logo']),
      businessAddress: ProfileModelM._parseString(json['businessAddress']),
      businessHours: json['businessHours'],
      certifications: json['certifications'],
      pocDetails: json['pocDetails'],
      profileStatus: ProfileModelM._parseString(json['profileStatus']),
      version: json['version'],
      createdAt: ProfileModelM._parseString(json['createdAt']),
      updatedAt: ProfileModelM._parseString(json['updatedAt']),
      deletedAt: ProfileModelM._parseString(json['deletedAt']),
    );
  }
}

// ─────────────────────────────────────────────
class ConnectorProfile {
  final String? id;
  final String? ownerUserId;
  final String? verificationId;
  final String? verificationType;
  final String? aadhaarHash;
  final dynamic verificationDetails;
  final String? verifiedAt;
  final dynamic pocDetails;
  final dynamic certifications;
  final String? profileStatus;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  ConnectorProfile({
    this.id,
    this.ownerUserId,
    this.verificationId,
    this.verificationType,
    this.aadhaarHash,
    this.verificationDetails,
    this.verifiedAt,
    this.pocDetails,
    this.certifications,
    this.profileStatus,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ConnectorProfile.fromJson(Map<String, dynamic> json) {
    return ConnectorProfile(
      id: ProfileModelM._parseString(json['id']),
      ownerUserId: ProfileModelM._parseString(json['ownerUserId']),
      verificationId: ProfileModelM._parseString(json['verificationId']),
      verificationType: ProfileModelM._parseString(json['verificationType']),
      aadhaarHash: ProfileModelM._parseString(json['aadhaarHash']),
      verificationDetails: json['verificationDetails'],
      verifiedAt: ProfileModelM._parseString(json['verifiedAt']),
      pocDetails: json['pocDetails'],
      certifications: json['certifications'],
      profileStatus: ProfileModelM._parseString(json['profileStatus']),
      version: json['version'],
      createdAt: ProfileModelM._parseString(json['createdAt']),
      updatedAt: ProfileModelM._parseString(json['updatedAt']),
      deletedAt: ProfileModelM._parseString(json['deletedAt']),
    );
  }
}