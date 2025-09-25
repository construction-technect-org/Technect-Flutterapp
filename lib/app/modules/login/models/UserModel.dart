class UserModel {
  int? id;
  int? roleId;
  String? roleName;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? mobileNumber;
  String? email;
  String? gst;
  String? image;
  String? marketPlace;
  String? marketPlaceRole;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.roleId,
    this.roleName,
    this.firstName,
    this.lastName,
    this.image,
    this.countryCode,
    this.mobileNumber,
    this.email,
    this.gst,
    this.marketPlace,
    this.marketPlaceRole,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    roleId: json["roleId"],
    roleName: json["roleName"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    countryCode: json["countryCode"],
    mobileNumber: json["mobileNumber"],
    marketPlace: json["marketPlace"],
    marketPlaceRole: json["marketPlaceRole"],
    email: json["email"],
    gst: json["gstNumber"],
    createdAt: json["createdAt"],
    image: json["profileImage"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roleId": roleId,
    "roleName": roleName,
    "firstName": firstName,
    "lastName": lastName,
    "countryCode": countryCode,
    "marketPlace": marketPlace,
    "marketPlaceRole": marketPlaceRole,
    "mobileNumber": mobileNumber,
    "email": email,
    "profileImage": image,
    "gstNumber": gst,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  // Helper method to get full name
  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
