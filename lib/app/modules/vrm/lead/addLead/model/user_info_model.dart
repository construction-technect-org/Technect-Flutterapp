class UserInfoModel {
  bool? success;
  String? message;
  Data? data;

  UserInfoModel({this.success, this.message, this.data});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  MerchantProfile? merchantProfile;
  ConnectorProfile? connectorProfile;
  List<Addresses>? addresses;
  List<SiteLocations>? siteLocations;

  Data(
      {this.user,
        this.merchantProfile,
        this.connectorProfile,
        this.addresses,
        this.siteLocations});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    merchantProfile = json['merchantProfile'] != null
        ? MerchantProfile.fromJson(json['merchantProfile'])
        : null;
    connectorProfile = json['connectorProfile'] != null
        ? ConnectorProfile.fromJson(json['connectorProfile'])
        : null;
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    if (json['siteLocations'] != null) {
      siteLocations = <SiteLocations>[];
      json['siteLocations'].forEach((v) {
        siteLocations!.add(SiteLocations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (merchantProfile != null) {
      data['merchantProfile'] = merchantProfile!.toJson();
    }
    if (connectorProfile != null) {
      data['connectorProfile'] = connectorProfile!.toJson();
    }
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    if (siteLocations != null) {
      data['siteLocations'] =
          siteLocations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? roleName;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? mobileNumber;
  String? email;
  String? gstNumber;
  String? marketPlace;
  String? marketPlaceRole;
  String? profileImage;
  bool? isNotificationSend;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.roleName,
        this.firstName,
        this.lastName,
        this.countryCode,
        this.mobileNumber,
        this.email,
        this.gstNumber,
        this.marketPlace,
        this.marketPlaceRole,
        this.profileImage,
        this.isNotificationSend,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['roleName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    countryCode = json['countryCode'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    gstNumber = json['gstNumber'];
    marketPlace = json['marketPlace'];
    marketPlaceRole = json['marketPlaceRole'];
    profileImage = json['profileImage'];
    isNotificationSend = json['isNotificationSend'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roleName'] = roleName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['countryCode'] = countryCode;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    data['gstNumber'] = gstNumber;
    data['marketPlace'] = marketPlace;
    data['marketPlaceRole'] = marketPlaceRole;
    data['profileImage'] = profileImage;
    data['isNotificationSend'] = isNotificationSend;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class MerchantProfile {
  int? id;
  String? businessName;
  String? businessEmail;
  String? businessContactNumber;
  String? alternativeBusinessContactNumber;
  String? gstinNumber;
  String? website;
  int? yearOfEstablished;
  String? logo;
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
  String? createdAt;
  String? updatedAt;

  MerchantProfile(
      {this.id,
        this.businessName,
        this.businessEmail,
        this.businessContactNumber,
        this.alternativeBusinessContactNumber,
        this.gstinNumber,
        this.website,
        this.yearOfEstablished,
        this.logo,
        this.profileCompletionPercentage,
        this.isProfileComplete,
        this.identityVerified,
        this.businessLicense,
        this.qualityAssurance,
        this.verificationStatus,
        this.trustScore,
        this.marketplaceTier,
        this.memberSince,
        this.businessHours,
        this.documents,
        this.createdAt,
        this.updatedAt,});

  MerchantProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    businessEmail = json['businessEmail'];
    businessContactNumber = json['businessContactNumber'];
    alternativeBusinessContactNumber = json['alternativeBusinessContactNumber'];
    gstinNumber = json['gstinNumber'];
    website = json['website'];
    yearOfEstablished = json['yearOfEstablished'];
    logo = json['logo'];
    profileCompletionPercentage = json['profileCompletionPercentage'];
    isProfileComplete = json['isProfileComplete'];
    identityVerified = json['identityVerified'];
    businessLicense = json['businessLicense'];
    qualityAssurance = json['qualityAssurance'];
    verificationStatus = json['verificationStatus'] != null
        ? VerificationStatus.fromJson(json['verificationStatus'])
        : null;
    trustScore = json['trustScore'];
    marketplaceTier = json['marketplaceTier'];
    memberSince = json['memberSince'];
    if (json['businessHours'] != null) {
      businessHours = <BusinessHours>[];
      json['businessHours'].forEach((v) {
        businessHours!.add(BusinessHours.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['businessName'] = businessName;
    data['businessEmail'] = businessEmail;
    data['businessContactNumber'] = businessContactNumber;
    data['alternativeBusinessContactNumber'] =
        alternativeBusinessContactNumber;
    data['gstinNumber'] = gstinNumber;
    data['website'] = website;
    data['yearOfEstablished'] = yearOfEstablished;
    data['logo'] = logo;
    data['profileCompletionPercentage'] = profileCompletionPercentage;
    data['isProfileComplete'] = isProfileComplete;
    data['identityVerified'] = identityVerified;
    data['businessLicense'] = businessLicense;
    data['qualityAssurance'] = qualityAssurance;
    if (verificationStatus != null) {
      data['verificationStatus'] = verificationStatus!.toJson();
    }
    data['trustScore'] = trustScore;
    data['marketplaceTier'] = marketplaceTier;
    data['memberSince'] = memberSince;
    if (businessHours != null) {
      data['businessHours'] =
          businessHours!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class VerificationStatus {
  bool? identityVerified;
  bool? businessLicense;
  bool? qualityAssurance;

  VerificationStatus(
      {this.identityVerified, this.businessLicense, this.qualityAssurance});

  VerificationStatus.fromJson(Map<String, dynamic> json) {
    identityVerified = json['identityVerified'];
    businessLicense = json['businessLicense'];
    qualityAssurance = json['qualityAssurance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identityVerified'] = identityVerified;
    data['businessLicense'] = businessLicense;
    data['qualityAssurance'] = qualityAssurance;
    return data;
  }
}

class BusinessHours {
  int? id;
  bool? isOpen;
  String? dayName;
  String? openTime;
  String? closeTime;
  int? dayOfWeek;

  BusinessHours(
      {this.id,
        this.isOpen,
        this.dayName,
        this.openTime,
        this.closeTime,
        this.dayOfWeek});

  BusinessHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOpen = json['is_open'];
    dayName = json['day_name'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    dayOfWeek = json['day_of_week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_open'] = isOpen;
    data['day_name'] = dayName;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['day_of_week'] = dayOfWeek;
    return data;
  }
}

class Documents {
  int? id;
  String? filePath;
  int? fileSize;
  String? mimeType;
  bool? isVerified;
  String? documentName;
  String? documentType;

  Documents(
      {this.id,
        this.filePath,
        this.fileSize,
        this.mimeType,
        this.isVerified,
        this.documentName,
        this.documentType});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filePath = json['file_path'];
    fileSize = json['file_size'];
    mimeType = json['mime_type'];
    isVerified = json['is_verified'];
    documentName = json['document_name'];
    documentType = json['document_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file_path'] = filePath;
    data['file_size'] = fileSize;
    data['mime_type'] = mimeType;
    data['is_verified'] = isVerified;
    data['document_name'] = documentName;
    data['document_type'] = documentType;
    return data;
  }
}

class ConnectorProfile {
  int? id;
  String? aadhaarNumber;
  String? panNumber;
  int? profileCompletionPercentage;
  bool? isProfileComplete;
  bool? kycVerified;
  String? trustScore;
  String? marketplaceTier;
  String? memberSince;
  String? createdAt;
  String? updatedAt;

  ConnectorProfile(
      {this.id,
        this.aadhaarNumber,
        this.panNumber,
        this.profileCompletionPercentage,
        this.isProfileComplete,
        this.kycVerified,
        this.trustScore,
        this.marketplaceTier,
        this.memberSince,
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Addresses {
  int? id;
  String? addressName;
  String? fullAddress;
  String? landmark;
  String? latitude;
  String? longitude;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
        this.addressName,
        this.fullAddress,
        this.landmark,
        this.latitude,
        this.longitude,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressName = json['addressName'];
    fullAddress = json['fullAddress'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addressName'] = addressName;
    data['fullAddress'] = fullAddress;
    data['landmark'] = landmark;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isDefault'] = isDefault;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SiteLocations {
  int? id;
  String? siteName;
  String? siteCode;
  String? fullAddress;
  String? landmark;
  String? latitude;
  String? longitude;
  bool? isDefault;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  SiteLocations(
      {this.id,
        this.siteName,
        this.siteCode,
        this.fullAddress,
        this.landmark,
        this.latitude,
        this.longitude,
        this.isDefault,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  SiteLocations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['siteName'];
    siteCode = json['siteCode'];
    fullAddress = json['fullAddress'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['isDefault'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['siteName'] = siteName;
    data['siteCode'] = siteCode;
    data['fullAddress'] = fullAddress;
    data['landmark'] = landmark;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['isDefault'] = isDefault;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
