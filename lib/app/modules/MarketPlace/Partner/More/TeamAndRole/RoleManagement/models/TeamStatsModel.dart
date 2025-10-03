class TeamStatsModel {
  bool? success;
  TeamStatsData? data;

  TeamStatsModel({this.success, this.data});

  factory TeamStatsModel.fromJson(Map<String, dynamic> json) => TeamStatsModel(
    success: json["success"],
    data: json["data"] == null ? null : TeamStatsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class TeamStatsData {
  String? totalTeamMembers;
  String? totalRoles;
  String? activeTeamMembers;
  String? activeRoles;

  TeamStatsData({
    this.totalTeamMembers,
    this.totalRoles,
    this.activeTeamMembers,
    this.activeRoles,
  });

  factory TeamStatsData.fromJson(Map<String, dynamic> json) => TeamStatsData(
    totalTeamMembers: json["total_team_members"],
    totalRoles: json["total_roles"],
    activeTeamMembers: json["active_team_members"],
    activeRoles: json["active_roles"],
  );

  Map<String, dynamic> toJson() => {
    "total_team_members": totalTeamMembers,
    "total_roles": totalRoles,
    "active_team_members": activeTeamMembers,
    "active_roles": activeRoles,
  };
}
