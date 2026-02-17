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
    return ProfileModelM(
      success: json['success'],
      message: json['message'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      merchantProfile: json['merchantProfile'] != null
          ? MerchantProfile.fromJson(json['merchantProfile'])
          : null,
      connectorProfile: json['connectorProfile'] != null
          ? ConnectorProfile.fromJson(json['connectorProfile'])
          : null,
    );
  }
}

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
      id: json['id'],
      countryCode: json['countryCode'],
      phone: json['phone'],
      email: json['email'],
      passwordHash: json['passwordHash'],
      provider: json['provider'],
      providerId: json['providerId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      referralCode: json['referralCode'],
      myReferralCode: json['myReferralCode'],
      phoneVerified: json['phoneVerified'],
      emailVerified: json['emailVerified'],
      lastActiveProfileId: json['lastActiveProfileId'],
      lastActiveProfileType: json['lastActiveProfileType'],
      status: json['status'],
      signupStatus: json['signupStatus'],
      sessionVersion: json['sessionVersion'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }
}

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
      id: json['id'],
      ownerUserId: json['ownerUserId'],
      verificationId: json['verificationId'],
      verificationType: json['verificationType'],
      gstinHash: json['gstinHash'],
      verificationDetails: json['verificationDetails'],
      verifiedAt: json['verifiedAt'],
      businessName: json['businessName'],
      businessType: json['businessType'],
      businessWebsite: json['businessWebsite'],
      businessEmail: json['businessEmail'],
      businessPhone: json['businessPhone'],
      alternateBusinessPhone: json['alternateBusinessPhone'],
      yearOfEstablish: json['yearOfEstablish'],
      logo: json['logo'],
      businessAddress: json['businessAddress'],
      businessHours: json['businessHours'],
      certifications: json['certifications'],
      pocDetails: json['pocDetails'],
      profileStatus: json['profileStatus'],
      version: json['version'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }
}

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
      id: json['id'],
      ownerUserId: json['ownerUserId'],
      verificationId: json['verificationId'],
      verificationType: json['verificationType'],
      aadhaarHash: json['aadhaarHash'],
      verificationDetails: json['verificationDetails'],
      verifiedAt: json['verifiedAt'],
      pocDetails: json['pocDetails'],
      certifications: json['certifications'],
      profileStatus: json['profileStatus'],
      version: json['version'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }
}
