class ForgotPasswordOtpModel {
  bool? success;
  String? message;
  Data? data;

  ForgotPasswordOtpModel({this.success, this.message, this.data});

  factory ForgotPasswordOtpModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordOtpModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? countryCode;
  String? mobileNumber;
  String? expiresIn;
  String? otp;
  bool? verified;

  Data({this.countryCode, this.mobileNumber, this.expiresIn, this.otp, this.verified});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        countryCode: json["countryCode"],
        mobileNumber: json["mobileNumber"],
        expiresIn: json["expiresIn"],
        otp: json["otp"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "countryCode": countryCode,
        "mobileNumber": mobileNumber,
        "expiresIn": expiresIn,
        "otp": otp,
        "verified": verified,
      };
}
