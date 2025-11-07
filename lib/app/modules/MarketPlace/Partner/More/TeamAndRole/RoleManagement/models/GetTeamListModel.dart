import 'package:construction_technect/app/modules/MarketPlace/Partner/Support/CustomerSupport/models/SupportMyTicketsModel.dart';

class TeamListModel {
  final bool? success;
  final List<TeamListData>? data;
  Statistics? statistics;

  final int? count;

  TeamListModel({this.success, this.data, this.count, this.statistics});

  factory TeamListModel.fromJson(Map<String, dynamic> json) => TeamListModel(
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<TeamListData>.from(
            json["data"]!.map((x) => TeamListData.fromJson(x)),
          ),
    count: json["count"],
    statistics: json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "count": count,
    'statistics': statistics?.toJson(),
  };
}

class A {
  bool? success;
  List<TeamListData>? teamListData;
  int? count;

  A({this.success, this.teamListData, this.count});

  A.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['teamListData'] != null) {
      teamListData = <TeamListData>[];
      json['teamListData'].forEach((v) {
        teamListData!.add(TeamListData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (teamListData != null) {
      data['teamListData'] = teamListData!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class TeamListData {
  int? id;
  int? merchantProfileId;
  int? teamRoleId;
  String? profilePhotoUrl;
  String? profilePhotoS3Key;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? roleTitle;
  String? roleDescription;
  String? functionalities;

  TeamListData({
    this.id,
    this.merchantProfileId,
    this.teamRoleId,
    this.profilePhotoUrl,
    this.profilePhotoS3Key,
    this.firstName,
    this.lastName,
    this.emailId,
    this.mobileNumber,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.roleTitle,
    this.roleDescription,
    this.functionalities,
  });

  TeamListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantProfileId = json['merchant_profile_id'];
    teamRoleId = json['team_role_id'];
    profilePhotoUrl = json['profile_photo_url'];
    profilePhotoS3Key = json['profile_photo_s3_key'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    emailId = json['email_id'];
    mobileNumber = json['mobile_number'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roleTitle = json['role_title'];
    roleDescription = json['role_description'];
    functionalities = json['functionalities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_profile_id'] = merchantProfileId;
    data['team_role_id'] = teamRoleId;
    data['profile_photo_url'] = profilePhotoUrl;
    data['profile_photo_s3_key'] = profilePhotoS3Key;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email_id'] = emailId;
    data['mobile_number'] = mobileNumber;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['role_title'] = roleTitle;
    data['role_description'] = roleDescription;
    data['functionalities'] = functionalities;
    return data;
  }
}
