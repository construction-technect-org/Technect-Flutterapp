class CompleteSignUpModel {
  CompleteSignUpModel({
    this.success,
    this.message,
    this.user,
    // this.merchantProfile,
    //this.connectorProfile,
    this.token,
    this.tokenType,
  });

  bool? success;
  String? message;
  UserMainModel? user;
  //MerchantProfile? merchantProfile;
  //ConnectorProfile? connectorProfile;
  String? token;
  String? tokenType;

  factory CompleteSignUpModel.fromJson(Map<String, dynamic> json) {
    return CompleteSignUpModel(
      success: json["success"],
      message: json["message"],
      user: json["user"] == null ? null : UserMainModel.fromJson(json["user"]),
      /* merchantProfile: json["merchantProfile"] == null
          ? null
          : MerchantProfile.fromJson(json["merchantProfile"]),
      connectorProfile: json["connectorProfile"] == null
          ? null
          : ConnectorProfile.fromJson(json["connectorProfile"]), */
      token: json["token"],
      tokenType: json["tokenType"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "user": user?.toJson(),
    // "merchantProfile": merchantProfile?.toJson(),
    // "connectorProfile": connectorProfile?.toJson(),
    "token": token,
    "tokenType": tokenType,
  };
}

/*class ConnectorProfile {
  ConnectorProfile({
    this.id,
    this.ownerUserId,
    this.verificationId,
    this.verificationType,
    this.verificationDetails,
    this.verifiedAt,
    this.profileStatus,
  });

  String? id;
  String? ownerUserId;
  String? verificationId;
  String? verificationType;
  ConnectorProfileVerificationDetails? verificationDetails;
  DateTime? verifiedAt;
  String? profileStatus;

  factory ConnectorProfile.fromJson(Map<String, dynamic> json) {
    return ConnectorProfile(
      id: json["id"],
      ownerUserId: json["ownerUserId"],
      verificationId: json["verificationId"],
      verificationType: json["verificationType"],
      verificationDetails: json["verificationDetails"] == null
          ? null
          : ConnectorProfileVerificationDetails.fromJson(
              json["verificationDetails"],
            ),
      verifiedAt: DateTime.tryParse(json["verifiedAt"] ?? ""),
      profileStatus: json["profileStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerUserId": ownerUserId,
    "verificationId": verificationId,
    "verificationType": verificationType,
    "verificationDetails": verificationDetails?.toJson(),
    "verifiedAt": verifiedAt?.toIso8601String(),
    "profileStatus": profileStatus,
  };
}

class ConnectorProfileVerificationDetails {
  ConnectorProfileVerificationDetails({
    this.aadharNumber,
    this.name,
    this.dateOfBirth,
    this.address,
    this.status,
    this.gender,
  });

  String? aadharNumber;
  String? name;
  String? dateOfBirth;
  String? address;
  String? status;
  String? gender;

  factory ConnectorProfileVerificationDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    return ConnectorProfileVerificationDetails(
      aadharNumber: json["aadharNumber"],
      name: json["name"],
      dateOfBirth: json["dateOfBirth"],
      address: json["address"],
      status: json["status"],
      gender: json["gender"],
    );
  }

  Map<String, dynamic> toJson() => {
    "aadharNumber": aadharNumber,
    "name": name,
    "dateOfBirth": dateOfBirth,
    "address": address,
    "status": status,
    "gender": gender,
  };
}

class MerchantProfile {
  MerchantProfile({
    this.id,
    this.ownerUserId,
    this.verificationId,
    this.verificationType,
    this.verificationDetails,
    this.verifiedAt,
    this.profileStatus,
  });

  String? id;
  String? ownerUserId;
  String? verificationId;
  String? verificationType;
  MerchantProfileVerificationDetails? verificationDetails;
  DateTime? verifiedAt;
  String? profileStatus;

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      id: json["id"],
      ownerUserId: json["ownerUserId"],
      verificationId: json["verificationId"],
      verificationType: json["verificationType"],
      verificationDetails: json["verificationDetails"] == null
          ? null
          : MerchantProfileVerificationDetails.fromJson(
              json["verificationDetails"],
            ),
      verifiedAt: DateTime.tryParse(json["verifiedAt"] ?? ""),
      profileStatus: json["profileStatus"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "ownerUserId": ownerUserId,
    "verificationId": verificationId,
    "verificationType": verificationType,
    "verificationDetails": verificationDetails?.toJson(),
    "verifiedAt": verifiedAt?.toIso8601String(),
    "profileStatus": profileStatus,
  };
}

class MerchantProfileVerificationDetails {
  MerchantProfileVerificationDetails({
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

  String? gstNumber;
  String? legalName;
  String? tradeName;
  String? address;
  String? registrationDate;
  String? status;
  String? businessType;
  String? centerJurisdiction;
  String? stateJurisdiction;

  factory MerchantProfileVerificationDetails.fromJson(
    Map<String, dynamic> json,
  ) {
    return MerchantProfileVerificationDetails(
      gstNumber: json["gstNumber"],
      legalName: json["legalName"],
      tradeName: json["tradeName"],
      address: json["address"],
      registrationDate: json["registrationDate"],
      status: json["status"],
      businessType: json["businessType"],
      centerJurisdiction: json["centerJurisdiction"],
      stateJurisdiction: json["stateJurisdiction"],
    );
  }

  Map<String, dynamic> toJson() => {
    "gstNumber": gstNumber,
    "legalName": legalName,
    "tradeName": tradeName,
    "address": address,
    "registrationDate": registrationDate,
    "status": status,
    "businessType": businessType,
    "centerJurisdiction": centerJurisdiction,
    "stateJurisdiction": stateJurisdiction,
  };
} */

class UserMainModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? lastActiveProfileType;
  final String? lastActiveProfileId;
  final Address? address;
  final String? referralCode;
  final String? myReferralCode;
  final String? fcmToken;
  final String? deviceType;

  UserMainModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.lastActiveProfileType,
    this.lastActiveProfileId,
    this.address,
    this.referralCode,
    this.myReferralCode,
    this.fcmToken,
    this.deviceType,
  });

  // factory UserMainModel.fromJson(Map<String, dynamic> json) {
  //   return UserMainModel(
  //     id: json["id"],
  //     firstName: json["firstName"],
  //     lastName: json["lastName"],
  //     phone: json["phone"],
  //     email: json["email"],
  //     lastActiveProfileType: json["lastActiveProfileType"],
  //     lastActiveProfileId: json["lastActiveProfileId"],
  //     address: json["address"] != null
  //         ? Address.fromJson(json["address"])
  //         : null,
  //     referralCode: json["referralCode"],
  //     myReferralCode: json["myReferralCode"],
  //     fcmToken: json["fcmToken"],
  //     deviceType: json["deviceType"],
  //   );
  // }
  factory UserMainModel.fromJson(Map<String, dynamic> json) {
    return UserMainModel(
      id: json["id"]?.toString(),
      firstName: json["firstName"]?.toString(),
      lastName: json["lastName"]?.toString(),
      phone: json["phone"]?.toString(),
      email: json["email"]?.toString(),
      lastActiveProfileType: json["lastActiveProfileType"]?.toString(),
      lastActiveProfileId: json["lastActiveProfileId"]?.toString(),
      address: json["address"] != null
          ? Address.fromJson(Map<String, dynamic>.from(json["address"]))
          : null,
      referralCode: json["referralCode"]?.toString(),
      myReferralCode: json["myReferralCode"]?.toString(),
      fcmToken: json["fcmToken"]?.toString(),
      deviceType: json["deviceType"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
    "lastActiveProfileType": lastActiveProfileType,
    "lastActiveProfileId": lastActiveProfileId,
    "address": address?.toJson(),
    "referralCode": referralCode,
    "myReferralCode": myReferralCode,
    "fcmToken": fcmToken,
    "deviceType": deviceType,
  };
}
class Address {
  final double? latitude;
  final double? longitude;

  Address({this.latitude, this.longitude});

  // factory Address.fromJson(Map<String, dynamic> json) {
  //   return Address(latitude: json["latitude"], longitude: json["longitude"]);
  // }
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      latitude: (json["latitude"] as num?)?.toDouble(),
      longitude: (json["longitude"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {"latitude": latitude, "longitude": longitude};
}