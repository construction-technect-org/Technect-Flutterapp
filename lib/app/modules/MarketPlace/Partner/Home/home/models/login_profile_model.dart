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
    data['id'] = this.id;
    data['countryCode'] = this.countryCode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['passwordHash'] = this.passwordHash;
    data['provider'] = this.provider;
    data['providerId'] = this.providerId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    if (this.address != null) {
      data['address'] = this.address?.toJson();
    }
    data['referralCode'] = this.referralCode;
    data['myReferralCode'] = this.myReferralCode;
    data['phoneVerified'] = this.phoneVerified;
    data['emailVerified'] = this.emailVerified;
    data['role'] = this.role;
    data['status'] = this.status;
    data['signupStatus'] = this.signupStatus;
    data['sessionVersion'] = this.sessionVersion;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
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
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
