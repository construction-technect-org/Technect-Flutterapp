import 'package:construction_technect/app/modules/Authentication/login/models/LoginModel.dart';
import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';

class ProfileModel {
  bool? success;
  Data? data;

  ProfileModel({this.success, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  UserModel? user;
  MerchantProfile? merchantProfile;
  ConnectorProfile? connectorProfile;
  Referral? referral;
  List<ManufacturerAddress>? addresses;
  List<SiteLocation>? siteLocations;
  StatisticsMC? statistics;
  TeamMemberModel? teamMember;
  bool? isTeamLogin;

  Data({
    this.user,
    this.merchantProfile,
    this.connectorProfile,
    this.referral,
    this.siteLocations,
    this.addresses,
    this.statistics,
    this.teamMember,
    this.isTeamLogin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    merchantProfile: json["merchantProfile"] == null
        ? null
        : MerchantProfile.fromJson(json["merchantProfile"]),
    connectorProfile: json["connectorProfile"] == null
        ? null
        : ConnectorProfile.fromJson(json["connectorProfile"]),
    referral: json["referral"] == null ? null : Referral.fromJson(json["referral"]),
    siteLocations: json["siteLocations"] == null
        ? []
        : (json["siteLocations"] as List).map((x) => SiteLocation.fromJson(x)).toList(),
    addresses: json["addresses"] == null
        ? []
        : (json["addresses"] as List).map((x) => ManufacturerAddress.fromJson(x)).toList(),
    statistics: json["statistics"] == null ? null : StatisticsMC.fromJson(json["statistics"]),
    teamMember: json["teamMember"] == null ? null : TeamMemberModel.fromJson(json["teamMember"]),
    isTeamLogin: json["isTeamLogin"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "merchantProfile": merchantProfile?.toJson(),
    "connectorProfile": connectorProfile?.toJson(),
    "referral": referral?.toJson(),
    "siteLocations": siteLocations == null
        ? []
        : List<dynamic>.from(siteLocations!.map((x) => x.toJson())),
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
    "statistics": statistics?.toJson(),
  };
}

class Referral {
  String? myReferralCode;
  int? totalReferrals;
  int? totalEarnings;
  List<ReferralUser>? recentReferrals;

  Referral({this.myReferralCode, this.totalReferrals, this.totalEarnings, this.recentReferrals});

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
    myReferralCode: json["my_referral_code"],
    totalReferrals: json["total_referrals"],
    totalEarnings: json["total_earnings"],
    recentReferrals: json["recent_referrals"] == null
        ? []
        : List<ReferralUser>.from(json["recent_referrals"]!.map((x) => ReferralUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "my_referral_code": myReferralCode,
    "total_referrals": totalReferrals,
    "total_earnings": totalEarnings,
    "recent_referrals": recentReferrals?.map((x) => x.toJson()).toList() ?? [],
  };
}

class ReferralUser {
  int? id;
  String? name;
  String? email;
  String? joinedAt;

  ReferralUser({this.id, this.name, this.email, this.joinedAt});

  factory ReferralUser.fromJson(Map<String, dynamic> json) => ReferralUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    joinedAt: json["joined_at"],
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email, "joined_at": joinedAt};
}

class MerchantProfile {
  dynamic id;
  String? businessName;
  dynamic merchantLogo;
  String? gstinNumber;
  String? businessEmail;
  String? businessContactNumber;
  String? alternativeBusinessContactNumber;
  String? businessWebsite;
  String? website;
  int? yearsInBusiness;
  int? projectsCompleted;
  int? profileCompletionPercentage;
  bool? isProfileComplete;
  bool? identityVerified;
  bool? businessLicense;
  bool? qualityAssurance;
  VerificationStatus? verificationStatus;
  String? trustScore;
  String? marketplaceTier;
  String? memberSince;
  List<BusinessHours>? businessHours;
  List<Documents>? documents;
  PointOfContact? pointOfContact;
  String? createdAt;
  String? updatedAt;

  MerchantProfile({
    this.id,
    this.businessName,
    this.gstinNumber,
    this.businessEmail,
    this.businessContactNumber,
    this.businessWebsite,
    this.yearsInBusiness,
    this.projectsCompleted,
    this.profileCompletionPercentage,
    this.isProfileComplete,
    this.alternativeBusinessContactNumber,
    this.website,
    this.identityVerified,
    this.businessLicense,
    this.qualityAssurance,
    this.verificationStatus,
    this.trustScore,
    this.marketplaceTier,
    this.merchantLogo,
    this.memberSince,
    this.businessHours,
    this.documents,
    this.pointOfContact,
    this.createdAt,
    this.updatedAt,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) => MerchantProfile(
    id: json["id"],
    businessName: json["businessName"],
    merchantLogo: json["logo"] is Map ? json["logo"]["url"] : json["logo"],
    gstinNumber: json["gstinNumber"] ?? json["gstNumber"],
    website: json["website"] ?? json["businessWebsite"],
    businessEmail: json["businessEmail"],
    businessContactNumber: json["businessContactNumber"] ?? json["businessPhone"],
    businessWebsite: json["businessWebsite"] ?? json["website"],
    yearsInBusiness: json["yearOfEstablish"] is int
        ? json["yearOfEstablish"]
        : int.tryParse(json["yearOfEstablish"]?.toString() ?? ""),
    projectsCompleted: json["projectsCompleted"],
    profileCompletionPercentage: json["profileCompletionPercentage"],
    isProfileComplete: json["isProfileComplete"],
    alternativeBusinessContactNumber:
        json["alternativeBusinessContactNumber"] ?? json["alternateBusinessPhone"],
    identityVerified: json["identityVerified"],
    businessLicense: json["businessLicense"],
    qualityAssurance: json["qualityAssurance"],
    verificationStatus: json["verificationStatus"] == null
        ? null
        : VerificationStatus.fromJson(json["verificationStatus"]),
    trustScore: json["trustScore"],
    marketplaceTier: json["marketplaceTier"],
    memberSince: json["memberSince"],
    businessHours: json["businessHours"] == null
        ? []
        : json["businessHours"] is List
        ? List<BusinessHours>.from(
            (json["businessHours"] as List).map((x) => BusinessHours.fromJson(x)),
          )
        : BusinessHours.fromMap(json["businessHours"]),
    documents: json["documents"] == null || json["documents"] is! List
        ? []
        : List<Documents>.from((json["documents"] as List).map((x) => Documents.fromJson(x))),
    pointOfContact: json["pointOfContact"] == null
        ? null
        : PointOfContact.fromJson(json["pointOfContact"]),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "businessName": businessName,
    "gstinNumber": gstinNumber,
    "gstNumber": gstinNumber,
    "logo": merchantLogo,
    "businessEmail": businessEmail,
    "businessContactNumber": businessContactNumber,
    "businessPhone": businessContactNumber,
    "businessWebsite": businessWebsite,
    "yearOfEstablish": yearsInBusiness,
    "yearOfEstablished": yearsInBusiness,
    "projectsCompleted": projectsCompleted,
    "profileCompletionPercentage": profileCompletionPercentage,
    "isProfileComplete": isProfileComplete,
    "identityVerified": identityVerified,
    "businessLicense": businessLicense,
    "qualityAssurance": qualityAssurance,
    "verificationStatus": verificationStatus?.toJson(),
    "trustScore": trustScore,
    "marketplaceTier": marketplaceTier,
    "memberSince": memberSince,
    "website": website,
    "alternativeBusinessContactNumber": alternativeBusinessContactNumber,
    "alternateBusinessPhone": alternativeBusinessContactNumber,
    "businessHours": businessHours == null
        ? []
        : List<dynamic>.from(businessHours!.map((x) => x.toJson())),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
    "pointOfContact": pointOfContact?.toJson(),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class VerificationStatus {
  bool? identityVerified;
  bool? businessLicense;
  bool? qualityAssurance;

  VerificationStatus({this.identityVerified, this.businessLicense, this.qualityAssurance});

  factory VerificationStatus.fromJson(Map<String, dynamic> json) => VerificationStatus(
    identityVerified: json["identityVerified"],
    businessLicense: json["businessLicense"],
    qualityAssurance: json["qualityAssurance"],
  );

  Map<String, dynamic> toJson() => {
    "identityVerified": identityVerified,
    "businessLicense": businessLicense,
    "qualityAssurance": qualityAssurance,
  };
}

class BusinessHours {
  int? id;
  bool? isOpen;
  String? dayName;
  String? openTime;
  String? closeTime;
  int? dayOfWeek;

  BusinessHours({
    this.id,
    this.isOpen,
    this.dayName,
    this.openTime,
    this.closeTime,
    this.dayOfWeek,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) => BusinessHours(
    id: json["id"],
    isOpen: json["is_open"] ?? (json["closed"] == null ? null : !(json["closed"] as bool)),
    dayName: json["day_name"],
    openTime: json["open_time"] ?? json["open"],
    closeTime: json["close_time"] ?? json["close"],
    dayOfWeek: json["day_of_week"],
  );

  static List<BusinessHours> fromMap(Map<String, dynamic> map) {
    final List<BusinessHours> list = [];
    final days = {
      'monday': 0,
      'tuesday': 1,
      'wednesday': 2,
      'thursday': 3,
      'friday': 4,
      'saturday': 5,
      'sunday': 6,
    };

    days.forEach((day, index) {
      if (map.containsKey(day)) {
        final dayData = map[day];
        if (dayData is Map<String, dynamic>) {
          list.add(
            BusinessHours(
              dayName: day[0].toUpperCase() + day.substring(1),
              dayOfWeek: index,
              isOpen: dayData["closed"] == null ? true : !(dayData["closed"] as bool),
              openTime: dayData["open"],
              closeTime: dayData["close"],
            ),
          );
        }
      }
    });
    return list;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_open": isOpen,
    "day_name": dayName,
    "open_time": openTime,
    "close_time": closeTime,
    "day_of_week": dayOfWeek,
  };
}

class ConnectorProfile {
  dynamic id;
  String? aadhaarNumber;
  String? panNumber;
  int? profileCompletionPercentage;
  bool? isProfileComplete;
  bool? kycVerified;
  String? trustScore;
  String? marketplaceTier;
  String? memberSince;
  List<Documents>? documents;
  PointOfContact? pointOfContact;
  TeamMember? teamMembers;
  String? createdAt;
  String? updatedAt;

  ConnectorProfile({
    this.id,
    this.aadhaarNumber,
    this.panNumber,
    this.profileCompletionPercentage,
    this.isProfileComplete,
    this.kycVerified,
    this.trustScore,
    this.marketplaceTier,
    this.memberSince,
    this.documents,
    this.pointOfContact,
    this.teamMembers,
    this.createdAt,
    this.updatedAt,
  });

  ConnectorProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aadhaarNumber = json['aadhaarNumber'];
    panNumber = json['panNumber'];
    profileCompletionPercentage = json['profileCompletionPercentage'];
    isProfileComplete = json['isProfileComplete'];
    kycVerified = json['kycVerified'];
    trustScore = json['trustScore'];
    marketplaceTier = json['marketplaceTier'];
    memberSince = json['memberSince'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
    pointOfContact = json['pointOfContact'] == null
        ? null
        : PointOfContact.fromJson(json['pointOfContact']);
    teamMembers = json['teamMembers'] == null ? null : TeamMember.fromJson(json['teamMembers']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aadhaarNumber'] = aadhaarNumber;
    data['panNumber'] = panNumber;
    data['profileCompletionPercentage'] = profileCompletionPercentage;
    data['isProfileComplete'] = isProfileComplete;
    data['kycVerified'] = kycVerified;
    data['trustScore'] = trustScore;
    data['marketplaceTier'] = marketplaceTier;
    data['memberSince'] = memberSince;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    if (pointOfContact != null) {
      data['pointOfContact'] = pointOfContact!.toJson();
    }
    if (teamMembers != null) {
      data['teamMembers'] = teamMembers!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Documents {
  dynamic id;
  String? filePath;
  int? fileSize;
  String? mimeType;
  bool? isVerified;
  String? documentName;
  String? documentType;

  Documents({
    this.id,
    this.filePath,
    this.fileSize,
    this.mimeType,
    this.isVerified,
    this.documentName,
    this.documentType,
  });

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
    id: json["id"],
    filePath: json["file_path"],
    fileSize: json["file_size"],
    mimeType: json["mime_type"],
    isVerified: json["is_verified"],
    documentName: json["document_name"],
    documentType: json["document_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_path": filePath,
    "file_size": fileSize,
    "mime_type": mimeType,
    "is_verified": isVerified,
    "document_name": documentName,
    "document_type": documentType,
  };
}

class DeleteDocumentResponse {
  bool? success;
  String? message;
  DeleteDocumentData? data;

  DeleteDocumentResponse({this.success, this.message, this.data});

  factory DeleteDocumentResponse.fromJson(Map<String, dynamic> json) => DeleteDocumentResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DeleteDocumentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "message": message, "data": data?.toJson()};
}

class DeleteDocumentData {
  Documents? deletedDocument;
  int? profileCompletionPercentage;
  bool? isProfileComplete;
  VerificationStatus? verificationStatus;

  DeleteDocumentData({
    this.deletedDocument,
    this.profileCompletionPercentage,
    this.isProfileComplete,
    this.verificationStatus,
  });

  factory DeleteDocumentData.fromJson(Map<String, dynamic> json) => DeleteDocumentData(
    deletedDocument: json["deleted_document"] == null
        ? null
        : Documents.fromJson(json["deleted_document"]),
    profileCompletionPercentage: json["profile_completion_percentage"],
    isProfileComplete: json["is_profile_complete"],
    verificationStatus: json["verification_status"] == null
        ? null
        : VerificationStatus.fromJson(json["verification_status"]),
  );

  Map<String, dynamic> toJson() => {
    "deleted_document": deletedDocument?.toJson(),
    "profile_completion_percentage": profileCompletionPercentage,
    "is_profile_complete": isProfileComplete,
    "verification_status": verificationStatus?.toJson(),
  };
}

class SiteLocation {
  dynamic id;
  String? siteName;
  String? fullAddress;
  String? landmark;
  String? latitude;
  String? longitude;
  bool? isDefault;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? siteCode;

  SiteLocation({
    this.id,
    this.siteName,
    this.fullAddress,
    this.landmark,
    this.latitude,
    this.longitude,
    this.siteCode,
    this.isDefault,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory SiteLocation.fromJson(Map<String, dynamic> json) => SiteLocation(
    id: json["id"],
    siteName: json["siteName"],
    siteCode: json["siteCode"],
    fullAddress: json["fullAddress"],
    landmark: json["landmark"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["isDefault"],
    isActive: json["isActive"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "siteName": siteName,
    "fullAddress": fullAddress,
    "landmark": landmark,
    "latitude": latitude,
    "longitude": longitude,
    "isDefault": isDefault,
    "isActive": isActive,
    "createdAt": createdAt,
    "siteCode": siteCode,
    "updatedAt": updatedAt,
  };
}

class ManufacturerAddress {
  dynamic id;
  String? addressName;
  String? fullAddress;
  String? landmark;
  String? latitude;
  String? longitude;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  ManufacturerAddress({
    this.id,
    this.addressName,
    this.fullAddress,
    this.landmark,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory ManufacturerAddress.fromJson(Map<String, dynamic> json) => ManufacturerAddress(
    id: json["id"],
    addressName: json["addressName"],
    fullAddress: json["fullAddress"],
    landmark: json["landmark"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["isDefault"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addressName": addressName,
    "fullAddress": fullAddress,
    "landmark": landmark,
    "latitude": latitude,
    "longitude": longitude,
    "isDefault": isDefault,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class StatisticsMC {
  int? totalMerchantProfilesCreated;
  int? totalConnectorProfilesCreated;

  StatisticsMC({this.totalMerchantProfilesCreated, this.totalConnectorProfilesCreated});

  factory StatisticsMC.fromJson(Map<String, dynamic> json) => StatisticsMC(
    totalMerchantProfilesCreated: json["totalMerchantProfilesCreated"],
    totalConnectorProfilesCreated: json["totalConnectorProfilesCreated"],
  );

  Map<String, dynamic> toJson() => {
    "totalMerchantProfilesCreated": totalMerchantProfilesCreated,
    "totalConnectorProfilesCreated": totalConnectorProfilesCreated,
  };
}

class PointOfContact {
  int? id;
  String? name;
  String? relation;
  String? phoneNumber;
  String? alternativePhoneNumber;
  String? email;
  String? createdAt;
  String? updatedAt;

  PointOfContact({
    this.id,
    this.name,
    this.relation,
    this.phoneNumber,
    this.alternativePhoneNumber,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory PointOfContact.fromJson(Map<String, dynamic> json) => PointOfContact(
    id: json["id"],
    name: json["name"] ?? json["pocName"],
    relation: json["relation"] ?? json["pocDesignation"],
    phoneNumber: json["phoneNumber"] ?? json["pocPhone"],
    alternativePhoneNumber: json["alternativePhoneNumber"] ?? json["pocAlternatePhone"],
    email: json["email"] ?? json["pocEmail"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "relation": relation,
    "phoneNumber": phoneNumber,
    "alternativePhoneNumber": alternativePhoneNumber,
    "email": email,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class TeamMember {
  int? id;
  int? numberOfMembers;
  String? name;
  String? phoneNumber;
  String? createdAt;
  String? updatedAt;

  TeamMember({
    this.id,
    this.numberOfMembers,
    this.name,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
    id: json["id"],
    numberOfMembers: json["numberOfMembers"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numberOfMembers": numberOfMembers,
    "name": name,
    "phoneNumber": phoneNumber,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
