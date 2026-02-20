class PersonaProfileModel {
  final bool? success;
  final List<Personas>? personas;

  PersonaProfileModel({
    this.success,
    this.personas,
  });

  factory PersonaProfileModel.fromJson(Map<String, dynamic> json) {
    return PersonaProfileModel(
      success: json['success'],
      personas: json['profiles'] != null
          ? List<Personas>.from(
        json['profiles'].map((x) => Personas.fromJson(x)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "profiles": personas?.map((x) => x.toJson()).toList(),
    };
  }
}
class Personas {
  final String? profileType;
  final String? profileId;
  final String? teamRole;
  final String? profileStatus;

  Personas({
    this.profileType,
    this.profileId,
    this.teamRole,
    this.profileStatus,
  });

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