class PersonaResponse {
  final bool? success;
  final List<Profile>? profiles;

  PersonaResponse({this.success, this.profiles});

  factory PersonaResponse.fromJson(Map<String, dynamic> json) {
    return PersonaResponse(
      success: json['success'] as bool?,
      profiles: json['profiles'] != null && json['profiles'] is List
          ? (json['profiles'] as List)
                .map((x) => Profile.fromJson(Map<String, dynamic>.from(x as Map)))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'profiles': profiles?.map((x) => x.toJson()).toList()};
  }
}

class Profile {
  final String? profileType;
  final String? profileId;
  final String? teamRole;
  final String? profileStatus;

  Profile({this.profileType, this.profileId, this.teamRole, this.profileStatus});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profileType: json['profileType'] as String?,
      profileId: json['profileId'] as String?,
      teamRole: json['teamRole'] as String?,
      profileStatus: json['profileStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profileType': profileType,
      'profileId': profileId,
      'teamRole': teamRole,
      'profileStatus': profileStatus,
    };
  }
}
