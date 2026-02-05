class PocModel {
  final bool? success;
  final Connector? connector;

  PocModel({
    this.success,
    this.connector,
  });

  factory PocModel.fromJson(Map<String, dynamic> json) {
    return PocModel(
      success: json['success'],
      connector: json['connector'] == null
          ? null
          : Connector.fromJson(json['connector']),
    );
  }
}

class Connector {
  final String? id;
  final String? ownerUserId;
  final String? verificationId;
  final String? verificationType;
  final String? aadhaarHash;
  final VerificationDetails? verificationDetails;
  final DateTime? verifiedAt;
  final PocDetails? pocDetails;
  final List<dynamic>? certifications;
  final String? profileStatus;
  final int? version;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Connector({
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

  factory Connector.fromJson(Map<String, dynamic> json) {
    return Connector(
      id: json['id'],
      ownerUserId: json['ownerUserId'],
      verificationId: json['verificationId'],
      verificationType: json['verificationType'],
      aadhaarHash: json['aadhaarHash'],
      verificationDetails: json['verificationDetails'] == null
          ? null
          : VerificationDetails.fromJson(json['verificationDetails']),
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt']),
      pocDetails: json['pocDetails'] == null
          ? null
          : PocDetails.fromJson(json['pocDetails']),
      certifications: json['certifications'],
      profileStatus: json['profileStatus'],
      version: json['version'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt']),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt']),
    );
  }
}

class VerificationDetails {
  final String? aadharNumber;
  final String? name;
  final String? dateOfBirth;
  final String? address;
  final String? status;
  final String? gender;

  VerificationDetails({
    this.aadharNumber,
    this.name,
    this.dateOfBirth,
    this.address,
    this.status,
    this.gender,
  });

  factory VerificationDetails.fromJson(Map<String, dynamic> json) {
    return VerificationDetails(
      aadharNumber: json['aadharNumber'],
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
