import 'UserModel.dart';

class LoginModel {
  bool? success;
  String? message;
  LoginData? data;

  LoginModel({this.success, this.message, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
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
