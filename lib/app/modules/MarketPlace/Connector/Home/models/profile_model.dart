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
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? status;
  final String? signupStatus;
  final bool? phoneVerified;
  final bool? emailVerified;

  User({
    this.id,
    this.countryCode,
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.status,
    this.signupStatus,
    this.phoneVerified,
    this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      countryCode: json['countryCode'],
      phone: json['phone'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      status: json['status'],
      signupStatus: json['signupStatus'],
      phoneVerified: json['phoneVerified'],
      emailVerified: json['emailVerified'],
    );
  }
}

class MerchantProfile {
  final String? id;
  final String? verificationType;
  final String? profileStatus;
  final VerificationDetails? verificationDetails;

  MerchantProfile({
    this.id,
    this.verificationType,
    this.profileStatus,
    this.verificationDetails,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      id: json['id'],
      verificationType: json['verificationType'],
      profileStatus: json['profileStatus'],
      verificationDetails: json['verificationDetails'] != null
          ? VerificationDetails.fromJson(json['verificationDetails'])
          : null,
    );
  }
}

class ConnectorProfile {
  final String? id;
  final String? verificationType;
  final String? profileStatus;
  final ConnectorVerificationDetails? verificationDetails;
  final PocDetails? pocDetails;

  ConnectorProfile({
    this.id,
    this.verificationType,
    this.profileStatus,
    this.verificationDetails,
    this.pocDetails,
  });

  factory ConnectorProfile.fromJson(Map<String, dynamic> json) {
    return ConnectorProfile(
      id: json['id'],
      verificationType: json['verificationType'],
      profileStatus: json['profileStatus'],
      verificationDetails: json['verificationDetails'] != null
          ? ConnectorVerificationDetails.fromJson(json['verificationDetails'])
          : null,
      pocDetails: json['pocDetails'] != null
          ? PocDetails.fromJson(json['pocDetails'])
          : null,
    );
  }
}

class VerificationDetails {
  final String? gstNumber;
  final String? legalName;
  final String? tradeName;
  final String? address;
  final String? status;

  VerificationDetails({
    this.gstNumber,
    this.legalName,
    this.tradeName,
    this.address,
    this.status,
  });

  factory VerificationDetails.fromJson(Map<String, dynamic> json) {
    return VerificationDetails(
      gstNumber: json['gstNumber'],
      legalName: json['legalName'],
      tradeName: json['tradeName'],
      address: json['address'],
      status: json['status'],
    );
  }
}

class ConnectorVerificationDetails {
  final String? name;
  final String? dateOfBirth;
  final String? address;
  final String? status;
  final String? gender;

  ConnectorVerificationDetails({
    this.name,
    this.dateOfBirth,
    this.address,
    this.status,
    this.gender,
  });

  factory ConnectorVerificationDetails.fromJson(
      Map<String, dynamic> json) {
    return ConnectorVerificationDetails(
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      status: json['status'],
      gender: json['gender'],
    );
  }
}

class PocDetails {
  final String? pocName;
  final String? pocDesignation;
  final String? pocPhone;
  final String? pocAlternatePhone;
  final String? pocEmail;

  PocDetails({
    this.pocName,
    this.pocDesignation,
    this.pocPhone,
    this.pocAlternatePhone,
    this.pocEmail,
  });

  factory PocDetails.fromJson(Map<String, dynamic> json) {
    return PocDetails(
      pocName: json['pocName'],
      pocDesignation: json['pocDesignation'],
      pocPhone: json['pocPhone'],
      pocAlternatePhone: json['pocAlternatePhone'],
      pocEmail: json['pocEmail'],
    );
  }
}
