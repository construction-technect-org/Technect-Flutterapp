class ProfileModel {
  final bool? success;
  final String? message;
  final UserM? user;
  final MerchantProfileM? merchantProfile;
  final ConnectorProfileM? connectorProfile;

  ProfileModel({
    this.success,
    this.message,
    this.user,
    this.merchantProfile,
    this.connectorProfile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json['success'],
      message: json['message'],
      user: json['user'] != null ? UserM.fromJson(json['user']) : null,
      merchantProfile: json['merchantProfile'] != null
          ? MerchantProfileM.fromJson(json['merchantProfile'])
          : null,
      connectorProfile: json['connectorProfile'] != null
          ? ConnectorProfileM.fromJson(json['connectorProfile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user?.toJson(),
      'merchantProfile': merchantProfile?.toJson(),
      'connectorProfile': connectorProfile?.toJson(),
    };
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}

class UserM {
  final dynamic id;
  final String? countryCode;
  final dynamic phone;
  final String? email;
  final String? passwordHash;
  final String? provider;
  final String? providerId;
  final String? firstName;
  final String? lastName;
  final dynamic address;
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
  final String? image;
  final String? deletedAt;

  UserM({
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
    this.image,
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

  factory UserM.fromJson(Map<String, dynamic> json) {
    return UserM(
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
      lastActiveProfileId: ProfileModel._parseString(json['lastActiveProfileId']),
      lastActiveProfileType: ProfileModel._parseString(json['lastActiveProfileType']),
      status: ProfileModel._parseString(json['status']),
      signupStatus: ProfileModel._parseString(json['signupStatus']),
      sessionVersion: json['sessionVersion'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      image: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'countryCode': countryCode,
      'phone': phone,
      'email': email,
      'passwordHash': passwordHash,
      'provider': provider,
      'providerId': providerId,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'referralCode': referralCode,
      'myReferralCode': myReferralCode,
      'phoneVerified': phoneVerified,
      'emailVerified': emailVerified,
      'lastActiveProfileId': lastActiveProfileId,
      'lastActiveProfileType': lastActiveProfileType,
      'status': status,
      'signupStatus': signupStatus,
      'sessionVersion': sessionVersion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'profileImage': image,
    };
  }
}

class MerchantProfileM {
  final dynamic id;
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
  final dynamic businessPhone;
  final dynamic alternateBusinessPhone;
  final dynamic yearOfEstablish;
  final dynamic logo;
  final String? businessAddress;
  final dynamic businessHours;
  final dynamic certifications;
  final dynamic pocDetails;
  final String? profileStatus;
  final bool? isProfileComplete;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  MerchantProfileM({
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
    this.isProfileComplete,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory MerchantProfileM.fromJson(Map<String, dynamic> json) {
    return MerchantProfileM(
      id: json['id'],
      ownerUserId: json['ownerUserId'],
      verificationId: json['verificationId'],
      verificationType: json['verificationType'],
      gstinHash: json['gstinHash'],
      verificationDetails: json['verificationDetails'],
      verifiedAt: ProfileModel._parseString(json['verifiedAt']),
      businessName: ProfileModel._parseString(json['businessName']),
      businessType: ProfileModel._parseString(json['businessType']),
      businessWebsite: ProfileModel._parseString(json['businessWebsite']),
      businessEmail: ProfileModel._parseString(json['businessEmail']),
      businessPhone: ProfileModel._parseString(json['businessPhone']),
      alternateBusinessPhone: ProfileModel._parseString(json['alternateBusinessPhone']),
      yearOfEstablish: ProfileModel._parseString(json['yearOfEstablish']),
      logo: ProfileModel._parseString(json['logo']),
      businessAddress: ProfileModel._parseString(json['businessAddress']),
      businessHours: json['businessHours'],
      certifications: json['certifications'],
      pocDetails: json['pocDetails'],
      profileStatus: json['profileStatus'],
      isProfileComplete: json['isProfileComplete'],
      version: json['version'],
      createdAt: ProfileModel._parseString(json['createdAt']),
      updatedAt: ProfileModel._parseString(json['updatedAt']),
      deletedAt: ProfileModel._parseString(json['deletedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerUserId': ownerUserId,
      'verificationId': verificationId,
      'verificationType': verificationType,
      'gstinHash': gstinHash,
      'verificationDetails': verificationDetails,
      'verifiedAt': verifiedAt,
      'businessName': businessName,
      'businessType': businessType,
      'businessWebsite': businessWebsite,
      'businessEmail': businessEmail,
      'businessPhone': businessPhone,
      'alternateBusinessPhone': alternateBusinessPhone,
      'yearOfEstablish': yearOfEstablish,
      'logo': logo,
      'businessAddress': businessAddress,
      'businessHours': businessHours,
      'certifications': certifications,
      'pocDetails': pocDetails,
      'profileStatus': profileStatus,
      'isProfileComplete': isProfileComplete,
      'version': version,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}

class ConnectorProfileM {
  final dynamic id;
  final String? ownerUserId;
  final String? verificationId;
  final String? verificationType;
  final String? aadhaarHash;
  final dynamic verificationDetails;
  final String? verifiedAt;
  final dynamic pocDetails;
  final dynamic certifications;
  final String? profileStatus;
  final bool? isProfileComplete;
  final int? version;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  ConnectorProfileM({
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
    this.isProfileComplete,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ConnectorProfileM.fromJson(Map<String, dynamic> json) {
    return ConnectorProfileM(
      id: json['id'],
      ownerUserId: json['ownerUserId'],
      verificationId: json['verificationId'],
      verificationType: json['verificationType'],
      aadhaarHash: json['aadhaarHash'],
      verificationDetails: json['verificationDetails'],
      verifiedAt: ProfileModel._parseString(json['verifiedAt']),
      pocDetails: json['pocDetails'],
      certifications: json['certifications'],
      profileStatus: json['profileStatus'],
      isProfileComplete: json['isProfileComplete'],
      version: json['version'],
      createdAt: ProfileModel._parseString(json['createdAt']),
      updatedAt: ProfileModel._parseString(json['updatedAt']),
      deletedAt: ProfileModel._parseString(json['deletedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerUserId': ownerUserId,
      'verificationId': verificationId,
      'verificationType': verificationType,
      'aadhaarHash': aadhaarHash,
      'verificationDetails': verificationDetails,
      'verifiedAt': verifiedAt,
      'pocDetails': pocDetails,
      'certifications': certifications,
      'profileStatus': profileStatus,
      'isProfileComplete': isProfileComplete,
      'version': version,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
