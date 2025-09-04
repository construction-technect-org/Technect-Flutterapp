import 'package:construction_technect/app/modules/login/models/UserModel.dart';

class ProfileModel {
  bool? success;
  Data? data;

  ProfileModel({this.success, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  UserModel? user;
  dynamic merchantProfile;

  Data({this.user, this.merchantProfile});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    merchantProfile: json["merchantProfile"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "merchantProfile": merchantProfile,
  };
}
