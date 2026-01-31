class ForgotPasswordOtpModel {
  bool? success;
  String? message;

  ForgotPasswordOtpModel({this.success, this.message});

  factory ForgotPasswordOtpModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordOtpModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {"success": success, "message": message};
}
