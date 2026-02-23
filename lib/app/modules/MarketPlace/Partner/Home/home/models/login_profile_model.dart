class LoginProfileModel {
  String? id;
  String? countryCode;
  String? phone;
  String? email;
  String? passwordHash;
  String? provider;
  String? providerId;
  String? firstName;
  String? lastName;
  Address? address;
  String? referralCode;
  String? myReferralCode;
  bool? phoneVerified;
  bool? emailVerified;
  String? role;
  String? status;
  String? signupStatus;
  int? sessionVersion;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  LoginProfileModel({
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
    this.referralCode,
    this.myReferralCode,
    this.phoneVerified,
    this.emailVerified,
    this.role,
    this.status,
    this.signupStatus,
    this.sessionVersion,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  LoginProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    email = json['email'];
    passwordHash = json['passwordHash'];
    provider = json['provider'];
    providerId = json['providerId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
    referralCode = json['referralCode'];
    myReferralCode = json['myReferralCode'];
    phoneVerified = json['phoneVerified'];
    emailVerified = json['emailVerified'];
    role = json['role'];
    status = json['status'];
    signupStatus = json['signupStatus'];
    sessionVersion = json['sessionVersion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['passwordHash'] = passwordHash;
    data['provider'] = provider;
    data['providerId'] = providerId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    if (address != null) {
      data['address'] = address?.toJson();
    }
    data['referralCode'] = referralCode;
    data['myReferralCode'] = myReferralCode;
    data['phoneVerified'] = phoneVerified;
    data['emailVerified'] = emailVerified;
    data['role'] = role;
    data['status'] = status;
    data['signupStatus'] = signupStatus;
    data['sessionVersion'] = sessionVersion;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}

class Address {
  double? latitude;
  double? longitude;

  Address({this.latitude, this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
