class OutgoingConnectionsResponse {
  final bool success;
  final List<OutgoingConnection> connections;

  OutgoingConnectionsResponse({
    required this.success,
    required this.connections,
  });

  factory OutgoingConnectionsResponse.fromJson(Map<String, dynamic> json) {
    return OutgoingConnectionsResponse(
      success: json['success'] ?? false,
      connections: (json['connections'] as List<dynamic>?)
          ?.map((e) =>
          OutgoingConnection.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class OutgoingConnection {
  final String id;
  final String connectorProfileId;
  final String merchantProfileId;
  final MerchantProfile? merchantProfile;
  final String requestedByProfileType;
  final String requestedByProfileId;
  final String requestedByUserId;
  final String status;
  final DateTime? requestedAt;
  final DateTime? respondedAt;
  final String? respondedByUserId;
  final DateTime? updatedAt;

  OutgoingConnection({
    required this.id,
    required this.connectorProfileId,
    required this.merchantProfileId,
    this.merchantProfile,
    required this.requestedByProfileType,
    required this.requestedByProfileId,
    required this.requestedByUserId,
    required this.status,
    this.requestedAt,
    this.respondedAt,
    this.respondedByUserId,
    this.updatedAt,
  });

  factory OutgoingConnection.fromJson(Map<String, dynamic> json) {
    return OutgoingConnection(
      id: json['id'] ?? '',
      connectorProfileId: json['connectorProfileId'] ?? '',
      merchantProfileId: json['merchantProfileId'] ?? '',
      merchantProfile: json['merchantProfile'] != null
          ? MerchantProfile.fromJson(
          json['merchantProfile'] as Map<String, dynamic>)
          : null,
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

class MerchantProfile {
  final String id;
  final String? businessName;
  final String? businessType;
  final String? businessWebsite;
  final String? businessEmail;
  final String? businessPhone;
  final String? alternateBusinessPhone;
  final int? yearOfEstablish;
  final String? profileStatus;
  final Logo? logo;
  final PocDetails? pocDetails;

  MerchantProfile({
    required this.id,
    this.businessName,
    this.businessType,
    this.businessWebsite,
    this.businessEmail,
    this.businessPhone,
    this.alternateBusinessPhone,
    this.yearOfEstablish,
    this.profileStatus,
    this.logo,
    this.pocDetails,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      id: json['id'] ?? '',
      businessName: json['businessName'],
      businessType: json['businessType'],
      businessWebsite: json['businessWebsite'],
      businessEmail: json['businessEmail'],
      businessPhone: json['businessPhone'],
      alternateBusinessPhone: json['alternateBusinessPhone'],
      yearOfEstablish: json['yearOfEstablish'] is int
          ? json['yearOfEstablish']
          : int.tryParse(json['yearOfEstablish']?.toString() ?? ''),
      profileStatus: json['profileStatus'],
      logo: json['logo'] != null
          ? Logo.fromJson(json['logo'] as Map<String, dynamic>)
          : null,
      pocDetails: json['pocDetails'] != null
          ? PocDetails.fromJson(json['pocDetails'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Logo {
  final String? key;
  final String? url;
  final int? size;
  final String? contentType;
  final String? originalName;

  Logo({
    this.key,
    this.url,
    this.size,
    this.contentType,
    this.originalName,
  });

  factory Logo.fromJson(Map<String, dynamic> json) {
    return Logo(
      key: json['key'],
      url: json['url'],
      size: json['size'] is int
          ? json['size']
          : int.tryParse(json['size']?.toString() ?? ''),
      contentType: json['contentType'],
      originalName: json['originalName'],
    );
  }
}

class PocDetails {
  final String? pocName;
  final String? pocEmail;
  final String? pocPhone;
  final String? pocDesignation;
  final String? pocAlternatePhone;

  PocDetails({
    this.pocName,
    this.pocEmail,
    this.pocPhone,
    this.pocDesignation,
    this.pocAlternatePhone,
  });

  factory PocDetails.fromJson(Map<String, dynamic> json) {
    return PocDetails(
      pocName: json['pocName'],
      pocEmail: json['pocEmail'],
      pocPhone: json['pocPhone'],
      pocDesignation: json['pocDesignation'],
      pocAlternatePhone: json['pocAlternatePhone'],
    );
  }
}