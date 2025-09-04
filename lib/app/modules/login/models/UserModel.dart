class UserModel {
  int? id;
  int? roleId;
  String? roleName;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? mobileNumber;
  String? email;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.roleId,
    this.roleName,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.mobileNumber,
    this.email,
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
    email: json["email"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "roleId": roleId,
    "roleName": roleName,
    "firstName": firstName,
    "lastName": lastName,
    "countryCode": countryCode,
    "mobileNumber": mobileNumber,
    "email": email,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

  // Helper method to get full name
  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
