class IncomingConnectionsResponse {
  final bool success;
  final List<IncomingConnection> connections;

  IncomingConnectionsResponse({
    required this.success,
    required this.connections,
  });

  factory IncomingConnectionsResponse.fromJson(Map<String, dynamic> json) {
    return IncomingConnectionsResponse(
      success: json['success'] ?? false,
      connections: (json['connections'] as List<dynamic>?)
          ?.map((e) =>
          IncomingConnection.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class IncomingConnection {
  final String id;
  final String connectorProfileId;
  final ConnectorProfile? connectorProfile;
  final String merchantProfileId;
  final String requestedByProfileType;
  final String requestedByProfileId;
  final String requestedByUserId;
  final String status;
  final DateTime? requestedAt;
  final DateTime? respondedAt;
  final String? respondedByUserId;
  final DateTime? updatedAt;

  IncomingConnection({
    required this.id,
    required this.connectorProfileId,
    this.connectorProfile,
    required this.merchantProfileId,
    required this.requestedByProfileType,
    required this.requestedByProfileId,
    required this.requestedByUserId,
    required this.status,
    this.requestedAt,
    this.respondedAt,
    this.respondedByUserId,
    this.updatedAt,
  });

  factory IncomingConnection.fromJson(Map<String, dynamic> json) {
    return IncomingConnection(
      id: json['id'] ?? '',
      connectorProfileId: json['connectorProfileId'] ?? '',
      connectorProfile: json['connectorProfile'] != null
          ? ConnectorProfile.fromJson(
          json['connectorProfile'] as Map<String, dynamic>)
          : null,
      merchantProfileId: json['merchantProfileId'] ?? '',
      requestedByProfileType: json['requestedByProfileType'] ?? '',
      requestedByProfileId: json['requestedByProfileId'] ?? '',
      requestedByUserId: json['requestedByUserId'] ?? '',
      status: json['status'] ?? '',
      requestedAt: json['requestedAt'] != null
          ? DateTime.tryParse(json['requestedAt'])
          : null,
      respondedAt: json['respondedAt'] != null
          ? DateTime.tryParse(json['respondedAt'])
          : null,
      respondedByUserId: json['respondedByUserId'],
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}

class ConnectorProfile {
  final String id;
  final String? ownerUserId;
  final String? verificationId;
  final String? verificationType;
  final String? aadhaarHash;
  final VerificationDetails? verificationDetails;
  final DateTime? verifiedAt;
  final String? profileStatus;
  final int? version;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ConnectorProfile({
    required this.id,
    this.ownerUserId,
    this.verificationId,
    this.verificationType,
    this.aadhaarHash,
    this.verificationDetails,
    this.verifiedAt,
    this.profileStatus,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ConnectorProfile.fromJson(Map<String, dynamic> json) {
    return ConnectorProfile(
      id: json['id'] ?? '',
      ownerUserId: json['ownerUserId'],
      verificationId: json['verificationId'],
      verificationType: json['verificationType'],
      aadhaarHash: json['aadhaarHash'],
      verificationDetails: json['verificationDetails'] != null
          ? VerificationDetails.fromJson(
          json['verificationDetails'] as Map<String, dynamic>)
          : null,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.tryParse(json['verifiedAt'])
          : null,
      profileStatus: json['profileStatus'],
      version: json['version'] is int
          ? json['version']
          : int.tryParse(json['version']?.toString() ?? ''),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.tryParse(json['deletedAt'])
          : null,
    );
  }
}

class VerificationDetails {
  final String? name;
  final String? gender;
  final String? status;
  final String? address;
  final String? dateOfBirth;
  final String? aadharNumber;

  VerificationDetails({
    this.name,
    this.gender,
    this.status,
    this.address,
    this.dateOfBirth,
    this.aadharNumber,
  });

  factory VerificationDetails.fromJson(Map<String, dynamic> json) {
    return VerificationDetails(
      name: json['name'],
      gender: json['gender'],
      status: json['status'],
      address: json['address'],
      dateOfBirth: json['dateOfBirth'],
      aadharNumber: json['aadharNumber'],
    );
  }
}