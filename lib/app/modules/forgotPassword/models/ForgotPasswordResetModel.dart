class ForgotPasswordResetModel {
  bool? success;
  String? message;
  Data? data;

  ForgotPasswordResetModel({this.success, this.message, this.data});

  factory ForgotPasswordResetModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResetModel(
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
  String? resetAt;

  Data({this.countryCode, this.mobileNumber, this.resetAt});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countryCode: json["countryCode"],
    mobileNumber: json["mobileNumber"],
    resetAt: json["resetAt"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "mobileNumber": mobileNumber,
    "resetAt": resetAt,
  };
}
