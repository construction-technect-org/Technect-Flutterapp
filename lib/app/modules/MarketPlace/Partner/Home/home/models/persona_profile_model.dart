class PersonaProfileModel {
  final bool? success;
  final List<Personas>? personas;

  PersonaProfileModel({this.success, this.personas});

  factory PersonaProfileModel.fromJson(Map<String, dynamic> json) {
    return PersonaProfileModel(
      success: json['success'] as bool?,
      personas: json['profiles'] is List
          ? (json['profiles'] as List).map((e) {
              return Personas.fromJson(Map<String, dynamic>.from(e as Map));
            }).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (personas != null) {
      data['profiles'] = personas?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Personas {
  final String? profileType;
  final String? profileId;
  final String? teamRole;
  final String? profileStatus;

  Personas({this.profileType, this.profileId, this.teamRole, this.profileStatus});

  factory Personas.fromJson(Map<String, dynamic> json) {
    return Personas(
      profileType: json['profileType'],
      profileId: json['profileId'],
      teamRole: json['teamRole'],
      profileStatus: json['profileStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profileType": profileType,
      "profileId": profileId,
      "teamRole": teamRole,
      "profileStatus": profileStatus,
    };
  }
}
