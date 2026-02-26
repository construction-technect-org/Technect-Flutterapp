class ConnectionsModel {
  final bool success;
  final List<Connection> connections;

  ConnectionsModel({
    required this.success,
    required this.connections,
  });

  factory ConnectionsModel.fromJson(Map<String, dynamic> json) {
    return ConnectionsModel(
      success: json['success'] ?? false,
      connections: (json['connections'] as List?)
          ?.map((e) => Connection.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class Connection {
  final String id;
  final String connectorProfileId;
  final ConnectorProfile? connectorProfile;
  final String merchantProfileId;
  final String requestedByProfileType;
  final String requestedByProfileId;
  final String requestedByUserId;
  final String status;
  final String requestedAt;
  final String? respondedAt;
  final String? respondedByUserId;
  final String updatedAt;

  Connection({
    required this.id,
    required this.connectorProfileId,
    this.connectorProfile,
    required this.merchantProfileId,
    required this.requestedByProfileType,
    required this.requestedByProfileId,
    required this.requestedByUserId,
    required this.status,
    required this.requestedAt,
    this.respondedAt,
    this.respondedByUserId,
    required this.updatedAt,
  });

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['id'] ?? '',
      connectorProfileId: json['connectorProfileId'] ?? '',
      connectorProfile: json['connectorProfile'] != null
          ? ConnectorProfile.fromJson(json['connectorProfile'])
          : null,
      merchantProfileId: json['merchantProfileId'] ?? '',
      requestedByProfileType: json['requestedByProfileType'] ?? '',
      requestedByProfileId: json['requestedByProfileId'] ?? '',
      requestedByUserId: json['requestedByUserId'] ?? '',
      status: json['status'] ?? '',
      requestedAt: json['requestedAt'] ?? '',
      respondedAt: json['respondedAt'],
      respondedByUserId: json['respondedByUserId'],
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class ConnectorProfile {
  final String id;
  final String ownerUserId;
  final String verificationId;
  final String verificationType;
  final String aadhaarHash;
  final VerificationDetails? verificationDetails;
  final String verifiedAt;
  final String profileStatus;
  final int version;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final dynamic pocDetails;
  final dynamic certifications;

  ConnectorProfile({
    required this.id,
    required this.ownerUserId,
    required this.verificationId,
    required this.verificationType,
    required this.aadhaarHash,
    this.verificationDetails,
    required this.verifiedAt,
    required this.profileStatus,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.pocDetails,
    this.certifications,
  });

  factory ConnectorProfile.fromJson(Map<String, dynamic> json) {
    return ConnectorProfile(
      id: json['id'] ?? '',
      ownerUserId: json['ownerUserId'] ?? '',
      verificationId: json['verificationId'] ?? '',
      verificationType: json['verificationType'] ?? '',
      aadhaarHash: json['aadhaarHash'] ?? '',
      verificationDetails: json['verificationDetails'] != null
          ? VerificationDetails.fromJson(json['verificationDetails'])
          : null,
      verifiedAt: json['verifiedAt'] ?? '',
      profileStatus: json['profileStatus'] ?? '',
      version: json['version'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      deletedAt: json['deletedAt'],
      pocDetails: json['pocDetails'],
      certifications: json['certifications'],
    );
  }
}

class VerificationDetails {
  final String name;
  final String gender;
  final String status;
  final String address;
  final String dateOfBirth;
  final String aadharNumber;

  VerificationDetails({
    required this.name,
    required this.gender,
    required this.status,
    required this.address,
    required this.dateOfBirth,
    required this.aadharNumber,
  });

  factory VerificationDetails.fromJson(Map<String, dynamic> json) {
    return VerificationDetails(
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      status: json['status'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      aadharNumber: json['aadharNumber'] ?? '',
    );
  }
}