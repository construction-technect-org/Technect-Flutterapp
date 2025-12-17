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
  TeamMemberModel? teamMember;
  bool? isTeamLogin;


  LoginData({
    this.token,
    this.user,
    this.teamMember,
    this.isTeamLogin,
  });
  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    token: json["token"],
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
    teamMember: json["teamMember"] == null
        ? null
        : TeamMemberModel.fromJson(json["teamMember"]),
    isTeamLogin: json["isTeamLogin"],
  );

  Map<String, dynamic> toJson() => {"token": token, "user": user?.toJson()};
}

class TeamMemberModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? profilePhoto;
  int? merchantProfileId;
  List<RoleModel>? roles;

  TeamMemberModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.profilePhoto,
    this.merchantProfileId,
    this.roles,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profilePhoto: json['profilePhoto'],
      mobileNumber: json['mobileNumber'],
      merchantProfileId: json['merchantProfileId'],
      roles: json['roles'] == null
          ? []
          : List<RoleModel>.from(
        json['roles'].map((x) => RoleModel.fromJson(x)),
      ),
    );
  }
}
class RoleModel {
  int? id;
  String? title;
  String? description;
  String? functionalities;

  RoleModel({
    this.id,
    this.title,
    this.description,
    this.functionalities,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    functionalities: json["functionalities"],
  );
}

