class UserDataModel {
  final String roleName;
  final String firstName;
  final String lastName;
  final String countryCode;
  final String mobileNumber;
  final String email;
  final String marketPlaceRole;
  final String gst;
  final String aadhaar;
  final String panCard;
  final String address;

  UserDataModel({
    required this.roleName,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobileNumber,
    required this.marketPlaceRole,
    required this.email,
    required this.aadhaar,
    required this.panCard,
    required this.address,
     this.gst="",
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "roleName": roleName,
    "lastName": lastName,
    "countryCode": countryCode,
    "mobileNumber": mobileNumber,
    "email": email,
    "aadharNumber": aadhaar,
    "marketPlaceRole": marketPlaceRole,
    "panCardNumber": panCard,
    "address": address,
    "gstNumber":gst
  };

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    roleName: json["roleName"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    countryCode: json["countryCode"] ?? "+91",
    mobileNumber: json["mobileNumber"] ?? "",
    marketPlaceRole: json["marketPlaceRole"] ?? "",
    email: json["email"] ?? "",
    gst: json["gstNumber"] ?? "",
    aadhaar: json["aadharNumber"] ?? "",
    panCard: json["panCardNumber"] ?? "",
    address: json["address"] ?? "",
  );
}
