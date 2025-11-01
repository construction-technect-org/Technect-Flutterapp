import 'package:construction_technect/app/modules/Authentication/login/models/UserModel.dart';

class LoginModel {
  bool? success;
  String? message;
  String? code;
  LoginData? data;

  LoginModel({this.success, this.message, this.code, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json["success"],
      message: json["message"],
      code: json["code"],
      data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "code": code,
    "data": data?.toJson(),
  };
}

class LoginData {
  String? token;
  UserModel? user;

  LoginData({this.token, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    token: json["token"],
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {"token": token, "user": user?.toJson()};
}
