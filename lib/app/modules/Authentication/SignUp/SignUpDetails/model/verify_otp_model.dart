class VerifyOTPModel {
  bool? success;
  String? message;
  User? user;
  String? token;
  String? tokenType;

  VerifyOTPModel({
    this.success,
    this.message,
    this.user,
    this.token,
    this.tokenType,
  });

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    tokenType = json['tokenType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['token'] = token;
    data['tokenType'] = tokenType;
    return data;
  }
}

class User {
  String? id;
  String? phone;
  String? email;
  bool? phoneVerified;
  String? status;
  String? countryCode;

  User({
    this.id,
    this.phone,
    this.email,
    this.phoneVerified,
    this.status,
    this.countryCode,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    phoneVerified = json['phoneVerified'];
    status = json['status'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['email'] = email;
    data['phoneVerified'] = phoneVerified;
    data['status'] = status;
    data['countryCode'] = countryCode;
    return data;
  }
}
