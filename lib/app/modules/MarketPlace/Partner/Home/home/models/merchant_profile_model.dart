import 'package:construction_technect/app/modules/CRM/lead/addLead/model/user_info_model.dart';

class MerchantProfileModel {
  bool? success;
  Merchant? merchant;

  MerchantProfileModel({this.success, this.merchant});

  MerchantProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    merchant = json['merchant'] != null
        ? Merchant.fromJson(json['merchant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    if (this.merchant != null) {
      data['merchant'] = this.merchant?.toJson();
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
    yearOfEstablish = json['yearOfEstablish'];
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
    pocDetails = json['pocDetails'] != null
        ? POC.fromJson(json['pocDetails'])
        : null;

    profileStatus = json['profileStatus'];
    version = json['version'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['ownerUserId'] = this.ownerUserId;
    data['verificationId'] = this.verificationId;
    data['verificationType'] = this.verificationType;
    data['gstinHash'] = this.gstinHash;
    if (this.verificationDetails != null) {
      data['verificationDetails'] = this.verificationDetails?.toJson();
    }
    data['verifiedAt'] = this.verifiedAt;
    data['businessName'] = this.businessName;
    data['businessType'] = this.businessType;
    data['businessWebsite'] = this.businessWebsite;
    data['businessEmail'] = this.businessEmail;
    data['businessPhone'] = this.businessPhone;
    data['alternateBusinessPhone'] = this.alternateBusinessPhone;
    data['yearOfEstablish'] = this.yearOfEstablish;
    if (this.logoKey != null) {
      data['logo'] = this.logoKey?.toJson();
    }
    data['businessAddress'] = this.businessAddress;
    if (this.businessHours != null) {
      data['businessHours'] = this.businessHours?.toJson();
    }
    if (this.certifications != null) {
      data['certifications'] = this.certifications
          ?.map((v) => v.toJson())
          .toList();
    }
    if (this.pocDetails != null) {
      data['pocDetails'] = this.pocDetails?.toJson();
    }

    data['profileStatus'] = this.profileStatus;
    data['version'] = this.version;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
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
    data['key'] = this.key;
    data['url'] = this.url;
    data['contentType'] = this.contentType;
    data['size'] = this.size;
    data['originalName'] = this.originalName;
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
    data['gstNumber'] = this.gstNumber;
    data['legalName'] = this.legalName;
    data['tradeName'] = this.tradeName;
    data['address'] = this.address;
    data['registrationDate'] = this.registrationDate;
    data['status'] = this.status;
    data['businessType'] = this.businessType;
    data['centerJurisdiction'] = this.centerJurisdiction;
    data['stateJurisdiction'] = this.stateJurisdiction;
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
    monday = json['monday'] != null
        ? MerchantDay.fromJson(json['monday'])
        : null;
    tuesday = json['tuesday'] != null
        ? MerchantDay.fromJson(json['tuesday'])
        : null;
    wednesday = json['wednesday'] != null
        ? MerchantDay.fromJson(json['wednesday'])
        : null;
    thursday = json['thursday'] != null
        ? MerchantDay.fromJson(json['thursday'])
        : null;
    friday = json['friday'] != null
        ? MerchantDay.fromJson(json['friday'])
        : null;
    saturday = json['saturday'] != null
        ? MerchantDay.fromJson(json['saturday'])
        : null;
    sunday = json['sunday'] != null
        ? MerchantDay.fromJson(json['sunday'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.monday != null) {
      data['monday'] = this.monday?.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday?.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday?.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday?.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday?.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday?.toJson();
    }
    if (this.sunday != null) {
      data['sunday'] = this.sunday?.toJson();
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
    data['open'] = this.open;
    data['close'] = this.close;
    data['closed'] = this.closed;
    return data;
  }
}

class POC {
  String? pocName;
  String? pocDesignation;
  String? pocPhone;
  String? pocAlternatePhone;
  String? pocEmail;

  POC({
    this.pocName,
    this.pocDesignation,
    this.pocPhone,
    this.pocAlternatePhone,
    this.pocEmail,
  });

  POC.fromJson(Map<String, dynamic> json) {
    pocName = json['pocName'];
    pocDesignation = json['pocDesignation'];
    pocPhone = json['pocPhone'];
    pocAlternatePhone = json['pocAlternatePhone'];
    pocEmail = json['pocEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pocName'] = this.pocName;
    data['pocDesignation'] = this.pocDesignation;
    data['pocPhone'] = this.pocPhone;
    data['pocAlternatePhone'] = this.pocAlternatePhone;
    data['pocEmail'] = this.pocEmail;
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
    data['url'] = this.url;
    data['key'] = this.key;
    data['uploadedAt'] = this.uploadedAt;
    data['originalName'] = this.originalName;
    data['size'] = this.size;
    data['contentType'] = this.contentType;
    data['title'] = this.title;
    return data;
  }
}
