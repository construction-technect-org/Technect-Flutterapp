class SendOtpModel {
  bool? success;
  String? message;
  Data? data;

  SendOtpModel({this.success, this.message, this.data});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? countryCode;
  String? mobileNumber;
  String? expiresIn;
  String? otp;

  Data({this.countryCode, this.mobileNumber, this.expiresIn, this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    mobileNumber = json['mobileNumber'];
    expiresIn = json['expiresIn'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['mobileNumber'] = mobileNumber;
    data['expiresIn'] = expiresIn;
    data['otp'] = otp;
    return data;
  }
}
