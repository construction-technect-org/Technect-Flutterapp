class UserDataModel {
  final String roleName;
  final String firstName;
  final String lastName;
  final String countryCode;
  final String mobileNumber;
  final String email;
  final String gst;

  UserDataModel({
    required this.roleName,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobileNumber,
    required this.email,
     this.gst="",
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "roleName": roleName,
    "lastName": lastName,
    "countryCode": countryCode,
    "mobileNumber": mobileNumber,
    "email": email,
    "gstNumber":gst
  };

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    roleName: json["roleName"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    countryCode: json["countryCode"] ?? "+91",
    mobileNumber: json["mobileNumber"] ?? "",
    email: json["email"] ?? "",
    gst: json["gstNumber"] ?? "",
  );
}
