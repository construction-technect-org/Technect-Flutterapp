
class MerchantProfileModel {
  bool? success;
  Merchant? merchant;

  MerchantProfileModel({this.success, this.merchant});

  MerchantProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    merchant = json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (merchant != null) {
      data['merchant'] = merchant?.toJson();
    }
    return data;
  }
}

class Merchant {
  String? id;
  String? ownerUserId;
  String? verificationId;
  String? verificationType;
  String? gstinHash;
  MerchantVerificationDetails? verificationDetails;
  String? verifiedAt;
  String? businessName;
  String? businessType;
  String? businessWebsite;
  String? businessEmail;
  String? businessPhone;
  String? alternateBusinessPhone;
  int? yearOfEstablish;
  Logo? logoKey;
  String? businessAddress;
  MerchantBusninessHours? businessHours;
  List<Cert>? certifications;
  POC? pocDetails;
  String? profileStatus;
  int? version;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Merchant({
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
    this.logoKey,
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

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerUserId = json['ownerUserId'];
    verificationId = json['verificationId'];
    verificationType = json['verificationType'];
    gstinHash = json['gstinHash'];
    verificationDetails = json['verificationDetails'] != null
        ? MerchantVerificationDetails.fromJson(json['verificationDetails'])
        : null;
    verifiedAt = json['verifiedAt'];
    businessName = json['businessName'];
    businessType = json['businessType'];
    businessWebsite = json['businessWebsite'];
    businessEmail = json['businessEmail'];
    businessPhone = json['businessPhone'];
    alternateBusinessPhone = json['alternateBusinessPhone'];
    yearOfEstablish = json['yearOfEstablish'] is int
        ? json['yearOfEstablish']
        : int.tryParse(json['yearOfEstablish']?.toString() ?? "");
    logoKey = json['logo'] != null ? Logo.fromJson(json['logo']) : null;

    businessAddress = json['businessAddress'];
    businessHours = json['businessHours'] != null
        ? MerchantBusninessHours.fromJson(json['businessHours'])
        : null;

    if (json['certifications'] != null) {
      certifications = <Cert>[];
      json['certifications'].forEach((v) {
        certifications?.add(Cert.fromJson(v));
      });
    }
    pocDetails = json['pocDetails'] != null ? POC.fromJson(json['pocDetails']) : null;

    profileStatus = json['profileStatus'];
    version = json['version'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ownerUserId'] = ownerUserId;
    data['verificationId'] = verificationId;
    data['verificationType'] = verificationType;
    data['gstinHash'] = gstinHash;
    if (verificationDetails != null) {
      data['verificationDetails'] = verificationDetails?.toJson();
    }
    data['verifiedAt'] = verifiedAt;
    data['businessName'] = businessName;
    data['businessType'] = businessType;
    data['businessWebsite'] = businessWebsite;
    data['businessEmail'] = businessEmail;
    data['businessPhone'] = businessPhone;
    data['alternateBusinessPhone'] = alternateBusinessPhone;
    data['yearOfEstablish'] = yearOfEstablish;
    if (logoKey != null) {
      data['logo'] = logoKey?.toJson();
    }
    data['businessAddress'] = businessAddress;
    if (businessHours != null) {
      data['businessHours'] = businessHours?.toJson();
    }
    if (certifications != null) {
      data['certifications'] = certifications?.map((v) => v.toJson()).toList();
    }
    if (pocDetails != null) {
      data['pocDetails'] = pocDetails?.toJson();
    }

    data['profileStatus'] = profileStatus;
    data['version'] = version;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}

class Logo {
  String? key;
  String? url;
  String? contentType;
  int? size;
  String? originalName;

  Logo({this.key, this.url, this.contentType, this.size, this.originalName});

  Logo.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    contentType = json['contentType'];
    size = json['size'];
    originalName = json['originalName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['url'] = url;
    data['contentType'] = contentType;
    data['size'] = size;
    data['originalName'] = originalName;
    return data;
  }
}

class MerchantVerificationDetails {
  String? gstNumber;
  String? legalName;
  String? tradeName;
  String? address;
  String? registrationDate;
  String? status;
  String? businessType;
  String? centerJurisdiction;
  String? stateJurisdiction;

  MerchantVerificationDetails({
    this.gstNumber,
    this.legalName,
    this.tradeName,
    this.address,
    this.registrationDate,
    this.status,
    this.businessType,
    this.centerJurisdiction,
    this.stateJurisdiction,
  });

  MerchantVerificationDetails.fromJson(Map<String, dynamic> json) {
    gstNumber = json['gstNumber'];
    legalName = json['legalName'];
    tradeName = json['tradeName'];
    address = json['address'];
    registrationDate = json['registrationDate'];
    status = json['status'];
    businessType = json['businessType'];
    centerJurisdiction = json['centerJurisdiction'];
    stateJurisdiction = json['stateJurisdiction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gstNumber'] = gstNumber;
    data['legalName'] = legalName;
    data['tradeName'] = tradeName;
    data['address'] = address;
    data['registrationDate'] = registrationDate;
    data['status'] = status;
    data['businessType'] = businessType;
    data['centerJurisdiction'] = centerJurisdiction;
    data['stateJurisdiction'] = stateJurisdiction;
    return data;
  }
}

class MerchantBusninessHours {
  MerchantDay? monday;
  MerchantDay? tuesday;
  MerchantDay? wednesday;
  MerchantDay? thursday;
  MerchantDay? friday;
  MerchantDay? saturday;
  MerchantDay? sunday;

  MerchantBusninessHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  MerchantBusninessHours.fromJson(Map json) {
    monday = json['monday'] != null ? MerchantDay.fromJson(json['monday']) : null;
    tuesday = json['tuesday'] != null ? MerchantDay.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null ? MerchantDay.fromJson(json['wednesday']) : null;
    thursday = json['thursday'] != null ? MerchantDay.fromJson(json['thursday']) : null;
    friday = json['friday'] != null ? MerchantDay.fromJson(json['friday']) : null;
    saturday = json['saturday'] != null ? MerchantDay.fromJson(json['saturday']) : null;
    sunday = json['sunday'] != null ? MerchantDay.fromJson(json['sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monday != null) {
      data['monday'] = monday?.toJson();
    }
    if (tuesday != null) {
      data['tuesday'] = tuesday?.toJson();
    }
    if (wednesday != null) {
      data['wednesday'] = wednesday?.toJson();
    }
    if (thursday != null) {
      data['thursday'] = thursday?.toJson();
    }
    if (friday != null) {
      data['friday'] = friday?.toJson();
    }
    if (saturday != null) {
      data['saturday'] = saturday?.toJson();
    }
    if (sunday != null) {
      data['sunday'] = sunday?.toJson();
    }
    return data;
  }
}

class MerchantDay {
  String? open;
  String? close;
  bool? closed;

  MerchantDay({this.open, this.close, this.closed});

  MerchantDay.fromJson(Map json) {
    open = json['open'];
    close = json['close'];
    closed = json['closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open'] = open;
    data['close'] = close;
    data['closed'] = closed;
    return data;
  }
}

class POC {
  String? pocName;
  String? pocDesignation;
  String? pocPhone;
  String? pocAlternatePhone;
  String? pocEmail;

  POC({this.pocName, this.pocDesignation, this.pocPhone, this.pocAlternatePhone, this.pocEmail});

  POC.fromJson(Map<String, dynamic> json) {
    pocName = json['pocName'];
    pocDesignation = json['pocDesignation'];
    pocPhone = json['pocPhone'];
    pocAlternatePhone = json['pocAlternatePhone'];
    pocEmail = json['pocEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pocName'] = pocName;
    data['pocDesignation'] = pocDesignation;
    data['pocPhone'] = pocPhone;
    data['pocAlternatePhone'] = pocAlternatePhone;
    data['pocEmail'] = pocEmail;
    return data;
  }
}

class Cert {
  String? url;
  String? key;
  String? uploadedAt;
  String? originalName;
  int? size;
  String? contentType;
  String? title;

  Cert({
    this.url,
    this.key,
    this.uploadedAt,
    this.originalName,
    this.size,
    this.contentType,
    this.title,
  });

  Cert.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    key = json['key'];
    uploadedAt = json['uploadedAt'];
    originalName = json['originalName'];
    size = json['size'];
    contentType = json['contentType'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['key'] = key;
    data['uploadedAt'] = uploadedAt;
    data['originalName'] = originalName;
    data['size'] = size;
    data['contentType'] = contentType;
    data['title'] = title;
    return data;
  }
}
